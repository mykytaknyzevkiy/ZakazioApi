package com.zakaion.api.controller.dashboard

import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.TransactionInDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.AppEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.web.bind.annotation.*
import java.util.*
import java.util.concurrent.TimeUnit
import kotlin.collections.ArrayList
import kotlin.collections.LinkedHashMap

@RestController
@CrossOrigin
@RequestMapping(value = ["dashboard"])
class DashboardController(private val orderDao: OrderDao,
                          private val userFactory: UserFactory,
                          private val userDao: UserDao,
                          private val transactionInDao: TransactionInDao) {

    @GetMapping("/system")
    @CanSuperAdmin_Admin_Editor
    fun system(@RequestParam(name = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") startDate: Date? = null,
               @RequestParam(name = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") endDate: Date? = null) : DataResponse<DashboardModel> {

        val realStartDate = startDate?:Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }.time

        val realEndDate = endDate?:Calendar.getInstance().apply {
            add(Calendar.DAY_OF_MONTH, 1)
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }.time

        val orderAnalytic : OrderAnalytic = {
            val orders = orderDao.findAll(
                    realStartDate,
                    realEndDate
            )

            val statuesOrder = linkedMapOf<String, Int>().apply {
                for (order in orders) {
                    this[order.status.data] = (this[order.status.data]?:0) + 1
                }
            }

            val partnersOrder = linkedMapOf<PartnerInfo, Int>().apply {
                for (order in orders) {
                    if (order.partner == null)
                        continue

                    val partner = userFactory.create(order.partner) as PartnerInfo

                    this[partner] = (this[partner]?:0) + 1
                }
            }

            val executorsOrder = linkedMapOf<ExecutorInfo, Int>().apply {
                for (order in orders) {
                    if (order.executor == null)
                        continue

                    val executor = userFactory.create(order.executor) as ExecutorInfo

                    this[executor] = (this[executor]?:0) + 1
                }
            }

            val appsOrder = linkedMapOf<AppEntity, Int>().apply {
                for (order in orders) {
                    if (order.app == null)
                        continue

                    this[order.app?:continue] = (this[order.app?:continue]?:0) + 1
                }
            }

            val datesOrder = linkedMapOf<String, Int>().apply {
                val diffTime = realEndDate.time - realStartDate.time
                for (order in orders) {
                    val keyName =
                            if (diffTime <= TimeUnit.DAYS.toMillis(1))
                                order.creationDateTime.hours.toString()
                            else if (diffTime < TimeUnit.DAYS.toMillis(7))
                                order.creationDateTime.date.toString()
                            else if (diffTime == TimeUnit.DAYS.toMillis(7))
                                order.creationDateTime.day.toString()
                            else if (diffTime >= TimeUnit.DAYS.toMillis(28) && diffTime <= TimeUnit.DAYS.toMillis(31))
                                order.creationDateTime.date.toString()
                            else if (diffTime >= ( TimeUnit.DAYS.toMillis(28) * 2))
                                order.creationDateTime.month.toString()
                            else
                                order.creationDateTime.time.toString()

                    this[keyName] = (this[keyName]?:0) + 1
                }
            }

            OrderAnalytic(
                    statuses = statuesOrder.toNikitaModelList(),
                    partners = partnersOrder.toNikitaModelList(),
                    executors = executorsOrder.toNikitaModelList(),
                    apps = appsOrder.toNikitaModelList(),
                    dates = datesOrder.toNikitaModelList()
            )
        }.invoke()

        val userAnalytic : Map<String, Int> = {
            linkedMapOf<String, Int>().apply {
                val users = userDao.findAll(
                        realStartDate,
                        realEndDate
                )
                for (user in users) {
                    this[user.role.data] = (this[user.role.data]?:0) + 1
                }
            }
        }.invoke()

        val transactionAnalytic : TransactionAnalytic = {
            var inComingSum = 0f

            val datesOrder = linkedMapOf<String, Float>()

            val transactionsIn = transactionInDao.findAll(realStartDate, realEndDate).filter {
                it.user.role == RoleType.SUPER_ADMIN
            }

            val diffTime = realEndDate.time - realStartDate.time

            for (transactionInEntity in transactionsIn) {
                val keyName =
                        if (diffTime <= TimeUnit.DAYS.toMillis(1))
                            transactionInEntity.creationDateTime.hours.toString()
                        else if (realStartDate.year != realEndDate.year)
                            transactionInEntity.creationDateTime.year.toString()
                        else if (diffTime < TimeUnit.DAYS.toMillis(7))
                            transactionInEntity.creationDateTime.date.toString()
                        else if (diffTime == TimeUnit.DAYS.toMillis(7))
                            transactionInEntity.creationDateTime.day.toString()
                        else if (diffTime >= TimeUnit.DAYS.toMillis(28) && diffTime <= TimeUnit.DAYS.toMillis(31))
                            transactionInEntity.creationDateTime.date.toString()
                        else if (diffTime >= ( TimeUnit.DAYS.toMillis(28) * 2))
                            (transactionInEntity.creationDateTime.month + 1).toString()
                        else
                            transactionInEntity.creationDateTime.time.toString()

                datesOrder[keyName] = (datesOrder[keyName]?:0f) + transactionInEntity.amount

                inComingSum += transactionInEntity.amount
            }

            TransactionAnalytic(
                    inComingSum = inComingSum,
                    dates = datesOrder.toNikitaModelList()
            )
        }.invoke()

        return DataResponse.ok(DashboardModel(
                oder = orderAnalytic,
                user = userAnalytic.toNikitaModelList(),
                transaction = transactionAnalytic
        ))
    }

    private fun <K, T> Map<K, T>.toNikitaModelList() : List<NikitaModel<K, T>> {
        return ArrayList<NikitaModel<K, T>>().apply {
            for (mutableEntry in this@toNikitaModelList) {
                this.add(NikitaModel(mutableEntry.key, mutableEntry.value))
            }
        }
    }

}