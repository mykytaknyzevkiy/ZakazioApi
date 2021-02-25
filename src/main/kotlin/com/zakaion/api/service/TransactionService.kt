package com.zakaion.api.service

import com.zakaion.api.dao.TransactionInDao
import com.zakaion.api.dao.TransactionOutDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.entity.transaction.TransactionOutEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.exception.BadParams
import org.springframework.stereotype.Service

@Service
class TransactionService(private val inDao: TransactionInDao,
                         private val outDao: TransactionOutDao,
                         private val userDao: UserDao) {

    fun userBalance(userID: Long) : Float {
        var sum = 0f
        inDao.find(userID).forEach {
            sum += it.amount
        }
        val inSum = sum

        var sum1 = 0f
        outDao.find(userID).forEach {
            sum1 += it.amount
        }
        val outSum = sum1

        return inSum - outSum
    }

    fun orderBalance(orderID: Long) : Float {
        var sum = 0f
        outDao.findOrder(orderID).forEach {
            sum += it.amount
        }
        return sum
    }

    fun processOrder(order: OrderEntity, amount: Float) {
        var systemAmount = amount

        val executorBalance = userBalance(
                order.executor?.id ?: throw BadParams()
        )

        if (executorBalance < amount)
            throw BadParams()

        outDao.save(
                TransactionOutEntity(
                        amount = amount,
                        card = null,
                        user = order.executor ?: throw BadParams(),
                        order = order
                )
        )

        if (order.partner != null) {
            val sum = amount * Preference.orderPartnerPercent / 100

            inDao.save(
                    TransactionInEntity(
                            amount = sum,
                            card = null,
                            user = order.partner ?: throw BadParams(),
                            order = order
                    )
            )

            systemAmount -= sum
        }

        if (order.executor?.masterID != null) {
            val executorMaster = userDao.findById(order.executor?.masterID ?: throw BadParams())
                    .orElseGet {
                        throw BadParams()
                    }

            val sum = amount * Preference.executorPartnerPercent / 100

            inDao.save(
                    TransactionInEntity(
                            amount = sum,
                            card = null,
                            user = executorMaster,
                            order = order
                    )
            )

            systemAmount -= sum
        }

        userDao.findAll().find { it.role == RoleType.SUPER_ADMIN }?.let { admin ->
            inDao.save(
                    TransactionInEntity(
                            amount = systemAmount,
                            card = null,
                            user = admin,
                            order = order
                    )
            )
        }
    }

}