package com.zakaion.api.controller.payment

import com.zakaion.api.dao.TransactionInDao
import com.zakaion.api.dao.TransactionOutDao
import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.entity.transaction.TransactionOutEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.factor.OrderFactor
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.FullTransactionResponse
import com.zakaion.api.model.TransactionImpResponse
import com.zakaion.api.model.TransactionOperation
import kotlinx.coroutines.*
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.domain.Sort
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.web.bind.annotation.*
import java.util.*
import java.util.function.Function

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["transaction"])
class TransactionController(
    private val transactionInDao: TransactionInDao,
    private val transactionOutDao: TransactionOutDao,
    private val orderFactor: OrderFactor) {

    @GetMapping("/user/{USER_ID}/list")
    fun listUser(pageable: Pageable,
             @PathVariable("USER_ID") userID: Long) : DataResponse<Page<TransactionImpResponse>> {
        val inList = transactionInDao.find(userID, pageable)
        val outList = transactionOutDao.find(userID, pageable)

        return DataResponse.ok(
            buildPageData(pageable, inList, outList)
        )
    }

    @GetMapping("/order/{ORDER_ID}/list")
    fun listOrder(pageable: Pageable,
                 @PathVariable("ORDER_ID") orderID: Long) : DataResponse<Page<TransactionImpResponse>> {
        val inList = transactionInDao.findOrder(orderID, pageable)
        val outList = transactionOutDao.findOrder(orderID, pageable)

        return DataResponse.ok(
            buildPageData(pageable, inList, outList)
        )
    }

    @GetMapping("/full")
    suspend fun full(
        @RequestParam(name = "start_date", required = true)
        @DateTimeFormat(pattern = "yyyy-MM-dd") startDate: Date,
        @RequestParam(name = "end_date", required = true)
        @DateTimeFormat(pattern = "yyyy-MM-dd") endDate: Date
    ): DataResponse<FullTransactionResponse> = withContext(Dispatchers.IO) {
        val inList = async(Dispatchers.IO) { transactionInDao.findAll(startDate, endDate) }
        val outList = async(Dispatchers.IO) { transactionOutDao.findAll(startDate, endDate) }

        val fullList = async(Dispatchers.IO) {
            val list = arrayListOf<TransactionImpResponse>()
            list.addAll(inList.await().map {
                TransactionImpResponse(
                    id = it.id,
                    amount = it.amount,
                    user = it.user,
                    card = it.card,
                    order = if (it.order != null) orderFactor.create(it.order!!) else null,
                    creationDateTime = it.creationDateTime,
                    operation = TransactionOperation.PLUS
                )
            })
            list.addAll(outList.await().map {
                TransactionImpResponse(
                    id = it.id,
                    amount = it.amount,
                    user = it.user,
                    card = it.card,
                    order = if (it.order != null) orderFactor.create(it.order!!) else null,
                    creationDateTime = it.creationDateTime,
                    operation = TransactionOperation.MINUS
                )
            })
            list.sortBy { it.creationDateTime.time }
            list
        }

        var systemAmount = 0f
        var partnerAmount = 0f
        var outFromSystemAmount = 0f

        withContext(Dispatchers.IO) {
            inList.await().forEach {
                if (it.user.role == RoleType.SUPER_ADMIN) {
                    systemAmount += it.amount
                } else if (it.user.role == RoleType.PARTNER) {
                    partnerAmount += it.amount
                }
            }
        }

        withContext(Dispatchers.IO) {
            outList.await().forEach {
                if (it.card != null) {
                    outFromSystemAmount += it.amount
                }
            }
        }

        return@withContext DataResponse.ok(
            FullTransactionResponse(
                systemAmount = systemAmount,
                partnerAmount = partnerAmount,
                outFromSystemAmount = outFromSystemAmount,
                list = fullList.await()
            )
        )
    }

    private fun buildPageData(
        pageable: Pageable,
        inList: Page<TransactionInEntity>,
        outList: Page<TransactionOutEntity>): Page<TransactionImpResponse> {

        return object : Page<TransactionImpResponse> {
            override fun getNumber(): Int = kotlin.math.max(inList.number, outList.number)

            override fun getTotalPages(): Int = kotlin.math.max(inList.totalPages, outList.totalPages)

            override fun iterator(): MutableIterator<TransactionImpResponse> = content.iterator()

            override fun <U : Any?> map(converter: Function<in TransactionImpResponse, out U>): Page<U> {
                return inList.map {
                    TransactionImpResponse(
                        id = it.id,
                        amount = it.amount,
                        user = it.user,
                        card = it.card,
                        order = if (it.order != null) orderFactor.create(it.order!!) else null,
                        creationDateTime = it.creationDateTime,
                        operation = TransactionOperation.PLUS
                    )
                }.map(converter)
            }

            override fun getSize(): Int = inList.size + inList.size

            override fun getNumberOfElements(): Int = inList.numberOfElements + outList.numberOfElements

            override fun getContent(): MutableList<TransactionImpResponse> {
                val list = arrayListOf<TransactionImpResponse>()
                list.addAll(inList.toList().map {
                    TransactionImpResponse(
                        id = it.id,
                        amount = it.amount,
                        user = it.user,
                        card = it.card,
                        order = if (it.order != null) orderFactor.create(it.order!!) else null,
                        creationDateTime = it.creationDateTime,
                        operation = TransactionOperation.PLUS
                    )
                })
                list.addAll(outList.toList().map {
                    TransactionImpResponse(
                        id = it.id,
                        amount = it.amount,
                        user = it.user,
                        card = it.card,
                        order = if (it.order != null) orderFactor.create(it.order!!) else null,
                        creationDateTime = it.creationDateTime,
                        operation = TransactionOperation.MINUS
                    )
                })
                list.sortBy { it.creationDateTime.time }

                return list.toMutableList()
            }

            override fun hasContent(): Boolean = true

            override fun getSort(): Sort = pageable.sort

            override fun isFirst(): Boolean = false

            override fun isLast(): Boolean = false

            override fun hasNext(): Boolean = iterator().hasNext()

            override fun hasPrevious(): Boolean = true

            override fun nextPageable(): Pageable = inList.nextPageable()

            override fun previousPageable(): Pageable = inList.previousPageable()

            override fun getTotalElements(): Long = inList.totalElements + outList.totalElements
        }
    }
}