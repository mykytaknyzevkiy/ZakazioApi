package com.zakaion.api.factor.user

import com.zakaion.api.factor.FullOrderClientImp
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.dao.PortfolioDao
import com.zakaion.api.entity.order.FeedbackEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserStatus
import com.zakaion.api.exception.BadParams
import com.zakaion.api.model.ClientInfo
import com.zakaion.api.model.ExecutorInfo
import com.zakaion.api.model.UserOrder

class FullOrderClientFactor(user: UserEntity,
                            private val orderDao: OrderDao,
                            private val feedbackDao: FeedbackDao,
                            private val passportDao: PassportDao,
                            private val portfolioDao: PortfolioDao) : UserImpFactor(user) {

    override fun create(): FullOrderClientImp {
        return when (user.role) {
            RoleType.EXECUTOR -> user.toExecutor(feedbackDao.findAll().toList())
            RoleType.CLIENT -> user.toClient(feedbackDao.findAll().toList())
            else -> throw BadParams()
        }
    }

    private fun UserEntity.toExecutor(allFeedbacks: List<FeedbackEntity>) : ExecutorInfo {
        val orders = orderDao.findUserOrders(this.id).toList()
        val portfolio = portfolioDao.findAll().filter { user.id == this.id }

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
                order = UserOrder.create(orders = orders),
                passport = passportDao.findAll().find { it.user.id == this.id },
                portfolioCount = portfolio.size
        ).apply {
            if (order.enable) {
                order.enable = this.isEmailActive && this.isPassportActive && this.isPhoneActive && portfolio.isNotEmpty() && this@toExecutor.status == UserStatus.ACTIVE
            }
            if (!order.enable && this.status == UserStatus.ACTIVE)
                this.status = UserStatus.PROCESS
        }
    }

    private fun UserEntity.toClient(allFeedbacks: List<FeedbackEntity>) : ClientInfo {
        val orders = orderDao.findUserOrders(this.id).toList()

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
                order = UserOrder.create(orders),
                passport = passportDao.findAll().find { it.user.id == this.id }
        ).apply {
            order.enable = true
        }
    }

}