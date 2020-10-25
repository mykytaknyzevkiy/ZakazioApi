package com.zakaion.api.repository

import com.zakaion.api.dao.CashInDao
import com.zakaion.api.dao.CashOutDao
import com.zakaion.api.dao.MoneyCircularDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.*
import org.springframework.stereotype.Service
import java.util.*

@Service
class CashRepository (
        private val cashInDao: CashInDao,
        private val cashOutDao: CashOutDao,
        private val moneyCircularDao: MoneyCircularDao,
        private val userDao: UserDao
) {

    fun moneyCircular() : MoneyCircularEntity {
        val list = moneyCircularDao.findAll().toList()
        if (list.isEmpty()) {
            val moneyCircularEntity = MoneyCircularEntity()
            moneyCircularDao.save(moneyCircularEntity)
            return moneyCircularEntity
        }
        return list.first()
    }

    fun circularOrder(orderEntity: OrderEntity) {
        val moneyCircular = moneyCircular()
        val totalSum = orderEntity.totalPrice * moneyCircular.fromExecutor / 100
        cashOutDao.save(
                CashOutEntity(
                        order = orderEntity,
                        user = orderEntity.executor!!,
                        price = totalSum
                )
        )
        if (orderEntity.executor?.partnerID != null) {
            val executorPartner = userDao.findById(orderEntity.executor?.partnerID!!).get()
            cashInDao.save(
                    CashInEntity(
                            order = orderEntity,
                            user = executorPartner,
                            price = totalSum * moneyCircular.executorPartner / 100
                    )
            )
        }
        cashInDao.save(
                CashInEntity(
                        order = orderEntity,
                        user = orderEntity.app.partner,
                        price = totalSum * moneyCircular.orderPartner / 100
                )
        )
        cashInDao.save(
                CashInEntity(
                        order = orderEntity,
                        user = userDao.findAll().find { it.isSuperAdmin }!!,
                        price = totalSum * moneyCircular.project / 100
                )
        )
    }

    fun projectBalance(): Float {
        val inCash = {
            var sum  = 0f
            cashInDao.findAll().filter { it.user.isSuperAdmin }.forEach { sum += it.price }
            sum
        }
        val ouCash = {
            var sum  = 0f
            cashOutDao.findAll().filter { it.user.isSuperAdmin }.forEach { sum += it.price }
            sum
        }

        return inCash() - ouCash()
    }

    fun projectBalance(startDate: Date, endDate: Date): Float {
        val inCash = {
            var sum  = 0f
            cashInDao.findAllByDate(startDate, endDate).filter { it.user.isSuperAdmin }.forEach { sum += it.price }
            sum
        }
        val ouCash = {
            var sum  = 0f
            cashOutDao.findAllByDate(startDate, endDate).filter { it.user.isSuperAdmin }.forEach { sum += it.price }
            sum
        }

        return inCash() - ouCash()
    }

    fun userBalance(userEntity: UserEntity): Float {
        if (userEntity.isSuperAdmin || userEntity.isAdmin || userEntity.isEditor)
            return projectBalance()

        val inCash = {
            var sum  = 0f
            cashInDao.findAll().filter { it.user.id == userEntity.id }.forEach { sum += it.price }
            sum
        }
        val ouCash = {
            var sum  = 0f
            cashOutDao.findAll().filter { it.user.id == userEntity.id }.forEach { sum += it.price }
            sum
        }

        return inCash() - ouCash()
    }

    fun userBalance(userEntity: UserEntity, startDate: Date, endDate: Date): Float {
        if (userEntity.isSuperAdmin || userEntity.isAdmin || userEntity.isEditor)
            return projectBalance(startDate, endDate)

        val inCash = {
            var sum  = 0f
            cashInDao.findAllByDate(startDate, endDate).filter { it.user.id == userEntity.id }.forEach { sum += it.price }
            sum
        }
        val ouCash = {
            var sum  = 0f
            cashOutDao.findAllByDate(startDate, endDate).filter { it.user.id == userEntity.id }.forEach { sum += it.price }
            sum
        }

        return inCash() - ouCash()
    }

}