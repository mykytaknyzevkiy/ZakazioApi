package com.zakaion.api.unit

import com.zakaion.api.dao.*
import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.service.SocketService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.withContext
import org.apache.poi.ss.usermodel.*
import org.springframework.stereotype.Service
import java.io.InputStream
import org.apache.poi.xssf.usermodel.XSSFWorkbook

@Service
class ImportExcellService(private val orderDao: OrderDao,
                          private val userDao: UserDao,
                          private val cityDao: CityDao,
                          private val regionDao: RegionDao,
                          private val categoryDao: CategoryDao,
                          private val childCategoryDao: ChildCategoryDao,
                          private val socketService: SocketService) {

    suspend fun processOrder(file: InputStream) = withContext(Dispatchers.IO) {
        val workbook: Workbook = XSSFWorkbook(file)

        val sheet = workbook.sheetIterator().next()
        
        val mainRow = sheet.first()
        val mainCells = arrayListOf<Cell>()

        mainRow.cellIterator().forEach {
            mainCells.add(it)
        }

        try {
            socketService.importOrderProcess(0, sheet.lastRowNum)
        } catch (e: Exception) {
            println(e)
        }

        for (index in 1..sheet.lastRowNum) {
            val row = sheet.getRow(index)

            val title = row.getCell(titleCellIndex(mainCells)).stringCellValue
            val content = row.getCell(contentCellIndex(mainCells)).stringCellValue
            val price = row.getCell(priceCellIndex(mainCells)).toString().toFloat()
            val dateLine = row.getCell(dateLineCellIndex(mainCells)).stringCellValue

            val regionName = row.getCell(regionCellIndex(mainCells)).stringCellValue
            val cityName = row.getCell(cityCellIndex(mainCells)).stringCellValue

            val categoryName = row.getCell(categoryCellIndex(mainCells)).stringCellValue
            val childCategoryName = row.getCell(childCategoryCellIndex(mainCells)).stringCellValue

            val clientName = row.getCell(clientNameCellIndex(mainCells)).stringCellValue
            val clientPhone = run {
                var clientPhone = row.getCell(clientPhoneCellIndex(mainCells)).toString()
                clientPhone = clientPhone.filter { it.isDigit() }
                /*clientPhone = if (clientPhone.startsWith("7"))
                    "+$clientPhone"
                else
                    "+7$clientPhone"*/
                clientPhone
            }
            val clientEmail = row.getCell(clientEmailCellIndex(mainCells)).stringCellValue

            if (title.isNullOrEmpty())
                return@withContext
            else if (content.isNullOrEmpty())
                return@withContext
            else if (price <= 0)
                return@withContext
            else if (dateLine.isNullOrEmpty())
                return@withContext

            if (regionName.isNullOrEmpty())
                return@withContext
            else if (cityName.isNullOrEmpty())
                return@withContext

            if (categoryName.isNullOrEmpty())
                return@withContext
            else if (childCategoryName.isNullOrEmpty())
                return@withContext

            if (clientName.isNullOrEmpty())
                return@withContext
            else if (clientEmail.isNullOrEmpty())
                return@withContext
            else if (clientPhone.isNullOrEmpty())
                return@withContext

            val client = async(Dispatchers.IO) {
                userDao.findAll().find {
                    it.phoneNumber == clientPhone && it.role == RoleType.CLIENT
                } ?: userDao.save(
                    UserEntity(
                        firstName = clientName.split(" ")[0],
                        lastName = clientName.split(" ").let {
                            if (it.size >= 2)
                                it[1]
                            else
                                ""
                        },
                        middleName =clientName.split(" ").let {
                            if (it.size >= 3)
                                it[2]
                            else
                                ""
                        },
                        email = clientEmail.replace(" ", ""),
                        phoneNumber = clientPhone
                    )
                )
            }

            val region = async(Dispatchers.IO) {
                regionDao.findAll().find {
                    it.name == regionName
                } ?: regionDao.save(
                    RegionEntity(
                        name = regionName,
                        code = 0
                    )
                )
            }
            val city = async(Dispatchers.IO) {
                cityDao.findAll().find {
                    it.name == cityName
                } ?: cityDao.save(
                    CityEntity(
                        name = cityName,
                        code = 0,
                        region = region.await()
                    )
                )
            }

            val category = async(Dispatchers.IO) {
                categoryDao.findAll().find {
                    it.name == categoryName
                } ?: categoryDao.save(
                    CategoryEntity(
                        name = categoryName
                    )
                )
            }
            val childCategory = async(Dispatchers.IO) {
                childCategoryDao.findAll().find {
                    it.parent.id == category.await().id && it.name == childCategoryName
                } ?: childCategoryDao.save(
                    ChildCategoryEntity(
                        name = childCategoryName,
                        parent = category.await()
                    )
                )
            }

            val order = OrderEntity(
                client = client.await(),
                title = title,
                content = content,
                price = price.toFloat(),
                category = category.await(),
                city = city.await(),
                dateLine = dateLine,
                files = emptyList(),
                // creationDateTime = creatingDate,
                childCategory = childCategory.await()
            )

            orderDao.save(order)

            try {
                socketService.importOrderProcess(index, sheet.lastRowNum)
            } catch (e: Exception) {
                println(e)
            }
        }

        try {
            socketService.importOrderDone(0, sheet.lastRowNum)
        } catch (e: Exception) {
            println(e)
        }
    }

    suspend fun processCategory(file: InputStream) = withContext(Dispatchers.IO) {
        val workbook: Workbook = XSSFWorkbook(file)

        val sheet = workbook.sheetIterator().next()

        val mainRow = sheet.first()
        val mainCells = arrayListOf<Cell>()

        mainRow.cellIterator().forEach {
            mainCells.add(it)
        }

        for (index in 1..sheet.lastRowNum) {
            val row = sheet.getRow(index)

            val categoryName = row.getCell(categoryCellIndex(mainCells)).stringCellValue
            val childCategoryName = row.getCell(childCategoryCellIndex(mainCells)).stringCellValue

            if (categoryName.isNullOrEmpty())
                return@withContext
            else if (childCategoryName.isNullOrEmpty())
                return@withContext

            val category = async(Dispatchers.IO) {
                categoryDao.findAll().find {
                    it.name == categoryName
                } ?: categoryDao.save(
                    CategoryEntity(
                        name = categoryName
                    )
                )
            }
            val childCategory = async(Dispatchers.IO) {
                childCategoryDao.findAll().find {
                    it.parent.id == category.await().id && it.name == childCategoryName
                } ?: childCategoryDao.save(
                    ChildCategoryEntity(
                        name = childCategoryName,
                        parent = category.await()
                    )
                )
            }

            childCategory.await()
        }
    }

    suspend fun processAddress(file: InputStream) = withContext(Dispatchers.IO) {
        val workbook: Workbook = XSSFWorkbook(file)

        val sheet = workbook.sheetIterator().next()

        val mainRow = sheet.first()
        val mainCells = arrayListOf<Cell>()

        mainRow.cellIterator().forEach {
            mainCells.add(it)
        }

        for (index in 1..sheet.lastRowNum) {
            val row = sheet.getRow(index)

            val regionName = row.getCell(regionCellIndex(mainCells)).stringCellValue
            val cityName = row.getCell(cityCellIndex(mainCells)).stringCellValue

            if (regionName.isNullOrEmpty())
                return@withContext
            else if (cityName.isNullOrEmpty())
                return@withContext

            val region = async(Dispatchers.IO) {
                regionDao.findAll().find {
                    it.name == regionName
                } ?: regionDao.save(
                    RegionEntity(
                        name = regionName,
                        code = 0
                    )
                )
            }
            val city = async(Dispatchers.IO) {
                cityDao.findAll().find {
                    it.name == cityName
                } ?: cityDao.save(
                    CityEntity(
                        name = cityName,
                        code = 0,
                        region = region.await()
                    )
                )
            }

            city.await()
        }
    }

    suspend fun processUser(file: InputStream, role: RoleType) = withContext(Dispatchers.IO) {
        val workbook: Workbook = XSSFWorkbook(file)

        val sheet = workbook.sheetIterator().next()

        val mainRow = sheet.first()
        val mainCells = arrayListOf<Cell>()

        mainRow.cellIterator().forEach {
            mainCells.add(it)
        }

        for (index in 1..sheet.lastRowNum) {
            val row = sheet.getRow(index)

            val clientName = row.getCell(clientNameCellIndex(mainCells)).stringCellValue
            val clientPhone = run {
                var clientPhone = row.getCell(clientPhoneCellIndex(mainCells)).stringCellValue
                clientPhone = clientPhone.replace(Regex("[^A-Za-z0-9 ]"), "")
                clientPhone = if (clientPhone.startsWith("7"))
                    "+$clientPhone"
                else
                    "+7$clientPhone"
                clientPhone
            }
            val clientEmail = row.getCell(clientEmailCellIndex(mainCells)).stringCellValue

            if (clientName.isNullOrEmpty())
                return@withContext
            else if (clientEmail.isNullOrEmpty())
                return@withContext
            else if (clientPhone.isNullOrEmpty())
                return@withContext

            val user = async(Dispatchers.IO) {
                userDao.findAll().find {
                    it.phoneNumber == clientPhone && it.role == role
                } ?: userDao.save(
                    UserEntity(
                        firstName = clientName.split(" ")[0],
                        lastName = clientName.split(" ").let {
                            if (it.size >= 2)
                                it[1]
                            else
                                ""
                        },
                        middleName =clientName.split(" ").let {
                            if (it.size >= 3)
                                it[2]
                            else
                                ""
                        },
                        email = clientEmail.replace(" ", ""),
                        phoneNumber = clientPhone,
                        role = role
                    )
                )
            }

            user.await()
        }
    }

    private fun findCellIndex(name: String, cells: List<Cell>): Int {
        var index = 0

        for (cell in cells) {
            if (cell.toString() == name) {
                break
            }
            index++
        }

        println("cell $name index = $index")

        return index
    }

    private fun titleCellIndex(cells: List<Cell>): Int = findCellIndex("<TITLE>", cells)

    private fun contentCellIndex(cells: List<Cell>): Int = findCellIndex("<CONTENT>", cells)

    private fun priceCellIndex(cells: List<Cell>): Int = findCellIndex("<CONST>", cells)

    private fun dateLineCellIndex(cells: List<Cell>): Int = findCellIndex("<DATE_LINE>", cells)

    private fun regionCellIndex(cells: List<Cell>): Int = findCellIndex("<REGION>", cells)

    private fun cityCellIndex(cells: List<Cell>): Int = findCellIndex("<CITY>", cells)

    private fun categoryCellIndex(cells: List<Cell>): Int = findCellIndex("<CATEGORY>", cells)

    private fun childCategoryCellIndex(cells: List<Cell>): Int = findCellIndex("<CHILD_CATEGORY>", cells)

    private fun clientNameCellIndex(cells: List<Cell>): Int = findCellIndex("<CLIENT_NAME>", cells)

    private fun clientPhoneCellIndex(cells: List<Cell>): Int = findCellIndex("<CLIENT_PHONE>", cells)

    private fun clientEmailCellIndex(cells: List<Cell>): Int = findCellIndex("<CLIENT_EMAIL>", cells)

}