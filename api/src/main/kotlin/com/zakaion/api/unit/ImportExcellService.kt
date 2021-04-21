package com.zakaion.api.unit

import com.zakaion.api.dao.*
import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.service.EmailService
import com.zakaion.api.service.SocketService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.withContext
import org.apache.poi.ss.usermodel.*
import org.springframework.stereotype.Service
import java.io.InputStream
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.springframework.format.datetime.DateFormatter
import java.util.*

@Service
class ImportExcellService(private val orderDao: OrderDao,
                          private val userDao: UserDao,
                          private val cityDao: CityDao,
                          private val regionDao: RegionDao,
                          private val categoryDao: CategoryDao,
                          private val childCategoryDao: ChildCategoryDao,
                          private val socketService: SocketService,
                          private val emailService: EmailService) {

    suspend fun processOrder(uuid: String, file: InputStream, partner: UserEntity? = null) = withContext(Dispatchers.IO) {
        val workbook: Workbook = XSSFWorkbook(file)

        val sheet = workbook.sheetIterator().next()

        val rows = run {
            val list = arrayListOf<Row>()
            sheet.rowIterator().forEach {
                if (it.getCell(0) != null && it.getCell(0).toString().isNotEmpty()) {
                    list.add(it)
                }
            }
            list
        }

        if (rows.isEmpty()) {
            return@withContext
        }

        val mainCells = arrayListOf<Cell>()

        rows.first().cellIterator().forEach {
            mainCells.add(it)
        }

        val brokers = arrayListOf<Pair<Int, String>>()

        val sendProcessSocketMsg: suspend (process: Int) -> Unit = {
            socketService.importOrderProcess(uuid = uuid, process = it+1, max = rows.size - 1, brokers = brokers)
        }

        val allOrders = orderDao.findAll().toMutableList()

        sendProcessSocketMsg.invoke(0)

        for (index in 1..rows.lastIndex) {
            val row = rows[index]

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
                clientPhone = if (!clientPhone.startsWith("+7"))
                    "+7$clientPhone"
                else
                    clientPhone
                clientPhone
            }
            val clientEmail = row.getCell(clientEmailCellIndex(mainCells)).stringCellValue

            val creatingDate = run {
                val dateStr = row.getCell(creatingDateCellIndex(mainCells)).stringCellValue
                try {
                    DateFormatter("dd.MM.yyyy").parse(dateStr, Locale.ROOT)
                } catch (e: Exception) {
                    println(e)
                    return@run Date()
                }
            }

            if (title.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует название заказа"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (content.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует описание заказа"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (price <= 0) {
                brokers.add(Pair(index, "Стоимость заказа меньше 0 или пуста"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (dateLine.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует предполагаемая дата заказа"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            if (regionName.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует название региона"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (cityName.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует название города"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            if (categoryName.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует название категории"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (childCategoryName.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует название подкатегории"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            if (clientName.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует имя клиента"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (clientEmail.isNullOrEmpty()) {
                brokers.add(Pair(index, "Отсуствует email клиента"))
                sendProcessSocketMsg.invoke(index)
                continue
            }
            else if (clientPhone.length <= 2) {
                brokers.add(Pair(index, "Отсуствует номер телефона клиента"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            else if (!clientPhone.startsWith("+7")) {
                brokers.add(Pair(index, "Номер телефона клиента не начинается с +7"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            val client = async(Dispatchers.IO) {
                userDao.findAll().find {
                    (it.phoneNumber == clientPhone || it.email == clientEmail) && it.role == RoleType.CLIENT
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
                        masterID = partner?.id
                    )
                )
            }

            val region = run {
                var region = regionDao.findAll().find {
                    it.name == regionName
                }
                if (region == null && partner == null) {
                    region = regionDao.save(
                        RegionEntity(
                            name = regionName,
                            code = 0
                        )
                    )
                }
                region
            }

            if (region == null) {
                brokers.add(Pair(index, "Не найден регион"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            val city = run {
                var city = cityDao.findAll().find {
                    it.name == cityName
                }
                if (city == null && partner == null) {
                    city = cityDao.save(
                        CityEntity(
                            name = cityName,
                            code = 0,
                            region = region
                        )
                    )
                }
                city
            }

            if (city == null) {
                brokers.add(Pair(index, "Не найден город"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            val category = run {
                var category = categoryDao.findAll().find {
                    it.name == categoryName
                }
                if (category == null && partner == null) {
                    category = categoryDao.save(
                        CategoryEntity(
                            name = categoryName
                        )
                    )
                }
                category
            }

            if (category == null) {
                brokers.add(Pair(index, "Не найдена категория"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            val childCategory = run {
                var cCategory = childCategoryDao.findAll().find {
                    it.parent.id == category.id && it.name == childCategoryName
                }
                if (cCategory == null && partner == null) {
                    cCategory = childCategoryDao.save(
                        ChildCategoryEntity(
                            name = childCategoryName,
                            parent = category
                        )
                    )
                }
                cCategory
            }

            if (childCategory == null) {
                brokers.add(Pair(index, "Не найдена подкатегория"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            if (allOrders.any {
                    it.title == title
                            && it.content == content
                            && it.client == it.client
                }) {
                brokers.add(Pair(index, "Такой заказ уже есть в системе"))
                sendProcessSocketMsg.invoke(index)
                continue
            }

            val order = OrderEntity(
                client = client.await(),
                title = title,
                content = content,
                price = price,
                category = category,
                city = city,
                dateLine = dateLine,
                files = emptyList(),
                creationDateTime = creatingDate,
                childCategory = childCategory,
                partner = partner
            )

            val save = orderDao.save(order)

            allOrders.add(save)

            sendProcessSocketMsg.invoke(index)
        }

        if (partner?.email != null) {
            emailService.sendImportDone(partner.email!!, rows.lastIndex, brokers)
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

    private fun creatingDateCellIndex(cells: List<Cell>): Int = findCellIndex("<DATE_CREATE>", cells)

}