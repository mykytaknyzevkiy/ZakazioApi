package com.zakaion.api.unit

import com.zakaion.api.dao.*
import com.zakaion.api.entity.order.CategoryEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import org.springframework.stereotype.Service
import java.io.InputStream
import org.apache.poi.hssf.usermodel.HeaderFooter.file
import org.apache.poi.ss.usermodel.CellType
import org.apache.poi.ss.usermodel.DateUtil
import org.apache.poi.ss.usermodel.Sheet

import org.apache.poi.xssf.usermodel.XSSFWorkbook

import org.apache.poi.ss.usermodel.Workbook
import java.text.SimpleDateFormat
import java.util.*


@Service
class ImportOrderExcell(private val orderDao: OrderDao,
                        private val userDao: UserDao,
                        private val cityDao: CityDao,
                        private val regionDao: RegionDao,
                        private val categoryDao: CategoryDao) {

    fun build(file: InputStream) {
        val workbook: Workbook = XSSFWorkbook(file)

        for (sheet in workbook.sheetIterator()) {
            try {
                processSheet(sheet)
            } catch (e: Exception) {
                println(e)
            }
        }

    }

    private fun processSheet(sheet: Sheet) {
        var titleRowNum: Int? = null
        var contentRowNum: Int? = null
        var priceRowNum: Int? = null
        var clientNameRowNum: Int? = null
        var regionRowNum: Int? = null
        var cityRowNum: Int? = null
        var phoneRowNum: Int? = null
        var emailRowNum: Int? = null
        var dateLineRowNum: Int? = null
        var categoryLineRowNum: Int? = null
        var creationDate: Int? = null

        val row = sheet.getRow(0)

        for ((num, cell) in row.cellIterator().withIndex()) {
            if (cell.cellTypeEnum != CellType.STRING)
                throw IllegalStateException()

            when (cell.stringCellValue) {
                "<name_adv>" -> titleRowNum = num
                "<text>" -> contentRowNum = num
                "<cost>" -> priceRowNum = num
                "<name_user>" -> clientNameRowNum = num
                "<region>" -> regionRowNum = num
                "<city>" -> cityRowNum = num
                "<phone>" -> phoneRowNum = num
                "<email>" -> emailRowNum = num
                "<time>" -> dateLineRowNum = num
                "<category>" -> categoryLineRowNum = num
                //"дата создания заказа" -> creationDate = num
                "<date_create>" -> creationDate = num
            }
        }

        if (titleRowNum == null ||
            contentRowNum == null ||
            priceRowNum == null ||
            clientNameRowNum == null ||
            regionRowNum == null ||
            cityRowNum == null ||
            phoneRowNum == null ||
            emailRowNum == null ||
            dateLineRowNum == null ||
            categoryLineRowNum == null ||
            creationDate == null)
                return

        for (index in 1..sheet.lastRowNum) {
            val row = sheet.getRow(index)

            val clientList = userDao.findAll().filter { it.role == RoleType.CLIENT }

            val categoryList = categoryDao.findAll()

            if (row.getCell(phoneRowNum).stringCellValue.isNullOrEmpty())
                continue
            else if (row.getCell(emailRowNum).stringCellValue.isNullOrEmpty())
                continue
            else if (row.getCell(priceRowNum).stringCellValue.isNullOrEmpty())
                continue
            else if (row.getCell(titleRowNum).stringCellValue.isNullOrEmpty())
                continue
            else if (row.getCell(contentRowNum).stringCellValue.isNullOrEmpty())
                continue
            else if (row.getCell(creationDate).toString().isNullOrEmpty())
                continue

            if (row.getCell(phoneRowNum).stringCellValue.isEmpty())
                continue
            if (row.getCell(emailRowNum).stringCellValue.isEmpty())
                continue
            if (row.getCell(clientNameRowNum).stringCellValue.isEmpty())
                continue

            val client: UserEntity = clientList.find {
                it.phoneNumber == row.getCell(phoneRowNum).stringCellValue
                    .replace(" ", "")
                    .replace("-", "") &&
                        it.email == row.getCell(emailRowNum).stringCellValue
                    .replace(" ", "")
            } ?: userDao.save(
                UserEntity(
                    firstName = row.getCell(clientNameRowNum).stringCellValue.split(" ")[0],
                    lastName = row.getCell(clientNameRowNum).stringCellValue.split(" ").let {
                        if (it.size >= 2)
                            it[1]
                        else
                            ""
                    },
                    middleName = row.getCell(clientNameRowNum).stringCellValue.split(" ").let {
                        if (it.size >= 3)
                            it[2]
                        else
                            ""
                    },
                    email = row.getCell(emailRowNum).stringCellValue.replace(" ", ""),
                    phoneNumber = row.getCell(phoneRowNum).stringCellValue
                        .replace(" ", "")
                        .replace("-", "")
                )
            )

            val category: CategoryEntity = categoryList.find {
                it.name == row.getCell(categoryLineRowNum).stringCellValue
            } ?: categoryDao.save(
                CategoryEntity(
                    name = row.getCell(categoryLineRowNum).stringCellValue
                )
            )

            val region: RegionEntity = regionDao.findAll().find {
                it.name == row.getCell(regionRowNum).stringCellValue
            } ?: regionDao.save(
                RegionEntity(
                    name = row.getCell(regionRowNum).stringCellValue,
                    code = 0
                )
            )

            val city: CityEntity = cityDao.findAll().find {
                it.name == row.getCell(cityRowNum).stringCellValue
            } ?: cityDao.save(
                CityEntity(
                    name = row.getCell(cityRowNum).stringCellValue,
                    code = 0,
                    region = region
                )
            )

            val creatingDate = try {
                DateUtil.getJavaDate(row.getCell(creationDate).numericCellValue)
            } catch (e: Exception) {
                continue
            }

            val order = OrderEntity(
                client = client,
                title = row.getCell(titleRowNum).stringCellValue,
                content = row.getCell(contentRowNum).stringCellValue,
                price = row.getCell(priceRowNum).stringCellValue.toFloat(),
                category = category,
                city = city,
                dateLine = row.getCell(dateLineRowNum).stringCellValue ?: "",
                files = emptyList(),
                creationDateTime = creatingDate
            )

            orderDao.save(order)
        }
    }

}