package com.zakaion.api.controller.dashboard

import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.TransactionInDao
import com.zakaion.api.dao.TransactionOutDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.AppEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.entity.transaction.TransactionImp
import com.zakaion.api.entity.transaction.creationCalendar
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.service.Preference
import kotlinx.coroutines.*
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.web.bind.annotation.*
import java.util.*
import java.util.concurrent.TimeUnit
import javax.servlet.http.Part
import kotlin.collections.ArrayList
import kotlin.collections.LinkedHashMap

@RestController
@CrossOrigin
@RequestMapping(value = ["dashboard"])
class DashboardController(private val orderDao: OrderDao,
                          private val userFactory: UserFactory,
                          private val userDao: UserDao,
                          private val transactionInDao: TransactionInDao,
                          private val transactionOutDao: TransactionOutDao) {

    @GetMapping("/system")
    fun system(@RequestParam(name = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") startDate: Date? = null,
               @RequestParam(name = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") endDate: Date? = null) : DataResponse<DashboardModel> {

        val realStartDate: Date = startDate?:Calendar.getInstance().apply {
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }.time

        val realEndDate: Date = endDate?:Calendar.getInstance().apply {
            add(Calendar.DAY_OF_MONTH, 1)
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 0)
            set(Calendar.MILLISECOND, 0)
        }.time

        val orderAnalytic : OrderAnalytic = orderAnalytic(orderDao.findAll(
            realStartDate,
            realEndDate
        ).toList(), realStartDate, realEndDate)

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

        val transactionAnalytic : TransactionAnalytic = transactionAnalytic(realStartDate, realEndDate)

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

    private fun orderAnalytic(orders: List<OrderEntity>, realStartDate: Date, realEndDate: Date) : OrderAnalytic {
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

            if (diffTime == TimeUnit.DAYS.toMillis(7)) {
                this["1"] = 0
                this["2"] = 0
                this["3"] = 0
                this["4"] = 0
                this["5"] = 0
                this["6"] = 0
                this["7"] = 0
            }

            for (order in orders) {
                var keyName = ""

                if (diffTime == TimeUnit.DAYS.toMillis(7)) {
                    keyName = order.creationCalendar().get(Calendar.DAY_OF_WEEK).toString()
                }
                else if (diffTime >= TimeUnit.DAYS.toMillis(7) && diffTime <= TimeUnit.DAYS.toMillis(31)) {
                    keyName = order.creationCalendar().get(Calendar.DAY_OF_MONTH).toString()
                }
                else if (realEndDate.year - realStartDate.year > 1) {

                    keyName = order.creationCalendar().get(Calendar.YEAR).toString()
                }
                else
                    keyName = order.creationCalendar().get(Calendar.MONTH).toString()

                this[keyName] = (this[keyName]?:0) + 1
            }
        }

        return OrderAnalytic(
            total = orders.count(),
            statuses = statuesOrder.toNikitaModelList(),
            partners = partnersOrder.toNikitaModelList(),
            executors = executorsOrder.toNikitaModelList(),
            apps = appsOrder.toNikitaModelList(),
            dates = datesOrder.toNikitaModelList()
        )
    }

    private fun transactionAnalytic(realStartDate: Date, realEndDate: Date) : TransactionAnalytic {
        val transactionsIn = transactionInDao.findAll(realStartDate, realEndDate)
        val transactionsOut = transactionOutDao.findAll(realStartDate, realEndDate)

        val orders = orderDao.findAll(realStartDate, realEndDate)

        var systemBalance = 0.0

        var totalInSum = 0.0
        var totalOutCardSum = 0.0

        var totalPartnerSum = 0.0

        var totalOrderSum = 0.0
        var totalInWaitOrderSum = 0.0
        var totalLostOrderSum = 0.0

        var totalSystemReceiveSum = 0.0

        transactionsIn.forEach {
            if (it.user.role == RoleType.SUPER_ADMIN)
                systemBalance += it.amount

            totalInSum += it.amount

            if (it.order != null && it.user.role == RoleType.PARTNER)
                totalPartnerSum += it.amount
        }

        transactionsOut.forEach {
            if (it.card != null)
                totalOutCardSum += it.amount
        }

        orders.forEach {
            when (it.status) {
                OrderStatus.DONE -> totalOrderSum += it.price
                OrderStatus.CANCEL -> totalLostOrderSum += it.price
                else -> {
                    totalInWaitOrderSum += it.price
                    totalSystemReceiveSum += it.price - (it.price * Preference.orderSumOutPercent / 100)
                }
            }
        }

        val datesOrder = linkedMapOf<String, Float>().apply {
            val diffTime = realEndDate.time - realStartDate.time

            if (diffTime == TimeUnit.DAYS.toMillis(7)) {
                this["1"] = 0f
                this["2"] = 0f
                this["3"] = 0f
                this["4"] = 0f
                this["5"] = 0f
                this["6"] = 0f
                this["7"] = 0f
            }
            else if (Calendar.getInstance()
                    .apply {
                        timeInMillis = realStartDate.time
                    }.get(Calendar.YEAR)
                -
                Calendar.getInstance()
                    .apply {
                        timeInMillis = realEndDate.time
                    }.get(Calendar.YEAR) > 1) {

                this[(Calendar.getInstance()
                    .apply {
                        timeInMillis = realStartDate.time
                    }.get(Calendar.YEAR)).toString()] = 0f
                this[(Calendar.getInstance()
                    .apply {
                        timeInMillis = realEndDate.time
                    }.get(Calendar.YEAR)).toString()] = 0f

            }

            for (order in transactionsIn) {
                if (order.user.role != RoleType.SUPER_ADMIN)
                    continue

                var keyName = ""

                if (diffTime == TimeUnit.DAYS.toMillis(7)) {
                    keyName = order.creationCalendar().get(Calendar.DAY_OF_WEEK).toString()
                }
                else if (diffTime >= TimeUnit.DAYS.toMillis(7) && diffTime <= TimeUnit.DAYS.toMillis(31)) {
                    keyName = order.creationCalendar().get(Calendar.DAY_OF_MONTH).toString()
                }
                else if (Calendar.getInstance()
                        .apply {
                            timeInMillis = realStartDate.time
                        }.get(Calendar.MONTH)
                    !=
                    Calendar.getInstance()
                        .apply {
                            timeInMillis = realEndDate.time
                        }.get(Calendar.MONTH)
                    || (Calendar.getInstance()
                        .apply {
                            timeInMillis = realStartDate.time
                        }.get(Calendar.YEAR)
                            !=
                            Calendar.getInstance()
                                .apply {
                                    timeInMillis = realEndDate.time
                                }.get(Calendar.YEAR))) {

                    keyName = order.creationCalendar().get(Calendar.MONTH).toString()
                }

                else if (Calendar.getInstance()
                        .apply {
                            timeInMillis = realStartDate.time
                        }.get(Calendar.YEAR)
                    -
                    Calendar.getInstance()
                        .apply {
                            timeInMillis = realEndDate.time
                        }.get(Calendar.YEAR) > 1) {

                    keyName = order.creationCalendar().get(Calendar.YEAR).toString()
                }
                else
                    continue

                this[keyName] = (this[keyName]?:0f) + order.amount
            }

        }

        return TransactionAnalytic(
            systemTotalSum = systemBalance,
            totalInSum = totalInSum,
            totalOutCardSum = totalOutCardSum,
            totalPartnerSum = totalPartnerSum,
            totalOrderSum = totalOrderSum,
            totalInWaitOrderSum = totalInWaitOrderSum,
            totalLostOrderSum = totalLostOrderSum,
            totalSystemReceiveSum = totalSystemReceiveSum,
            dates = datesOrder.toNikitaModelList()
        )
    }

    @GetMapping("/executors")
    suspend fun executors(@RequestParam(name = "start_date")
                  @DateTimeFormat(pattern = "yyyy-MM-dd") startDate: Date,
                  @RequestParam(name = "end_date")
                  @DateTimeFormat(pattern = "yyyy-MM-dd") endDate: Date): DataResponse<List<DashBoardExecutor>> = withContext(Dispatchers.IO) {
        val orders = async(Dispatchers.IO) {orderDao.findAll(startDate, endDate)}

        val executors = async(Dispatchers.IO) {
            val list = setOf<UserEntity>()
            orders.await().forEach { order ->
                if (order.executor != null)
                    list.plus(order.executor)
            }
            list
        }

        val transactions = async(Dispatchers.IO) {
            val list = arrayListOf<TransactionImp>()
            list.addAll(transactionInDao.findAll(startDate, endDate))
            list.addAll(transactionOutDao.findAll(startDate, endDate))
            list.sortBy { it.creationDateTime.time }
            list
        }

        val data = async(Dispatchers.IO) {
            val list = arrayListOf<DashBoardExecutor>()
            executors.await().forEach { executorEntity ->
                val eOrders = async(Dispatchers.IO) {
                    orders.await().filter {
                        it.executor?.id == executorEntity.id
                    }
                }
                val eTransactions = async(Dispatchers.IO) {
                    val orderIds = eOrders.await().map { it.id }
                    val list = arrayListOf<TransactionImp>()
                    transactions.await().forEach { transaction ->
                        if (orderIds.contains(transaction.order?.id))
                            list.add(transaction)
                    }
                    list
                }

                val executorInfo = async(Dispatchers.IO) {
                    userFactory.create(executorEntity) as ExecutorInfo
                }
                val partners = async(Dispatchers.IO) {
                    val list = arrayListOf<UserEntity>()
                    eOrders.await().forEach { order ->
                        if (order.partner != null) {
                            list.add(order.partner)
                        }
                    }
                    list
                        .map {
                        async(Dispatchers.IO) {
                            userFactory.create(it) as PartnerInfo
                        }
                    }
                        .awaitAll()
                }
                val childCategories = async(Dispatchers.IO) {
                    eOrders
                        .await()
                        .map {
                            it.childCategory
                        }
                }
                val orderInWorkCount = async(Dispatchers.IO) {
                    var count = 0
                    eOrders.await().forEach { order ->
                        if (order.status == OrderStatus.IN_WORK)
                            count++
                    }
                    count
                }
                val orderCancelCount = async(Dispatchers.IO) {
                    var count = 0
                    eOrders.await().forEach { order ->
                        if (order.status == OrderStatus.CANCEL)
                            count++
                    }
                    count
                }
                val orderDoneCount = async(Dispatchers.IO) {
                    var count = 0
                    eOrders.await().forEach { order ->
                        if (order.status == OrderStatus.DONE)
                            count++
                    }
                    count
                }
                val ordersSum = async(Dispatchers.IO) {
                    var count = 0f
                    eOrders.await().forEach { order ->
                        count += order.price
                    }
                    count
                }
                val partnerAmount = async(Dispatchers.IO) {
                    var sum = 0f
                    eTransactions.await().forEach { transaction ->
                        if (transaction.user.role == RoleType.PARTNER)
                            sum += transaction.amount
                    }
                    sum
                }
                val systemAmount = async(Dispatchers.IO) {
                    var sum = 0f
                    eTransactions.await().forEach { transaction ->
                        if (transaction.user.role == RoleType.SUPER_ADMIN)
                            sum += transaction.amount
                    }
                    sum
                }

                val element = DashBoardExecutor(
                    executor = executorInfo.await(),
                    partners = partners.await(),
                    childCategories = childCategories.await(),
                    orderInWorkCount = orderInWorkCount.await(),
                    orderCancelCount = orderCancelCount.await(),
                    orderDoneCount = orderDoneCount.await(),
                    ordersSum = ordersSum.await(),
                    partnerAmount = partnerAmount.await(),
                    systemAmount = systemAmount.await()
                )

                list.add(element)
            }
            list
        }

        return@withContext DataResponse.ok(data.await())
    }
}

data class DashBoardExecutor(
    val executor: ExecutorInfo,

    val partners: List<PartnerInfo>,

    val childCategories: List<ChildCategoryEntity>,

    val orderInWorkCount: Int,

    val orderCancelCount: Int,

    val orderDoneCount: Int,

    val ordersSum: Float,

    val partnerAmount: Float,

    val systemAmount: Float
)