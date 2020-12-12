package com.zakaion.api.factor.user

import com.zakaion.api.factor.FullOrderClientImp
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.entity.order.FeedbackEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.ClientInfo
import com.zakaion.api.model.ExecutorInfo
import com.zakaion.api.model.UserOrder

class FullOrderClientFactor(user: UserEntity,
                            private val orderDao: OrderDao,
                            private val feedbackDao: FeedbackDao,
                            private val passportDao: PassportDao) : UserImpFactor(user) {

    override fun create(): FullOrderClientImp {
        return when (user.role) {
            RoleType.EXECUTOR -> user.toExecutor(feedbackDao.findAll().toList(), orderDao.findAll().toList())
            RoleType.CLIENT -> user.toClient(feedbackDao.findAll().toList(), orderDao.findAll().toList())
            else -> throw BadParams()
        }
    }

    private fun UserEntity.toExecutor(allFeedbacks: List<FeedbackEntity>,
                                      allOrders: List<OrderEntity>) : ExecutorInfo {

        if (this.role != RoleType.EXECUTOR)
            throw NotFound()

        return ExecutorInfo(
                user = this,
                rate = {
                    val myFeedbacks = allFeedbacks.filter { it.user.id == this.id }
                    if (myFeedbacks.isEmpty()) 0f
                    else {
                        val stars = {
                            var num = 0
                            myFeedbacks.forEach { num += it.stars }
                            num
                        }.invoke()
                        (stars / allFeedbacks.size).toFloat()
                    }
                }.invoke(),
                order = UserOrder.create(allOrders.filter { it.executor?.id == this.id }).apply {
                    if (this.enable) {
                        this.enable = this@toExecutor.isPassportActive && this@toExecutor.isEmailActive && this@toExecutor.isPassportActive
                    }
                },
                passport = passportDao.findAll().find { it.user.id == this.id }
        )
    }

    private fun UserEntity.toClient(allFeedbacks: List<FeedbackEntity>,
                                    allOrders: List<OrderEntity>) : ClientInfo {

        if (this.role != RoleType.EXECUTOR)
            throw NotFound()

        return ClientInfo(
                user = this,
                rate = {
                    val myFeedbacks = allFeedbacks.filter { it.user.id == this.id }
                    if (myFeedbacks.isEmpty()) 0f
                    else {
                        val stars = {
                            var num = 0
                            myFeedbacks.forEach { num += it.stars }
                            num
                        }.invoke()
                        (stars / allFeedbacks.size).toFloat()
                    }
                }.invoke(),
                order = UserOrder.create(allOrders.filter { it.executor?.id == this.id }).apply {
                    if (this.enable) {
                        this.enable = this@toClient.isPassportActive && this@toClient.isEmailActive && this@toClient.isPassportActive
                    }
                },
                passport = passportDao.findAll().find { it.user.id == this.id }
        )
    }

}