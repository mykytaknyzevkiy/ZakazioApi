package com.zakaion.api.factor.user

import com.zakaion.api.factor.FullOrderClientImp
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.dao.PortfolioDao
import com.zakaion.api.dao.history.OrderHistoryDao
import com.zakaion.api.entity.history.OrderHistoryType
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
                            private val portfolioDao: PortfolioDao,
                            private val orderHistoryDao: OrderHistoryDao
) : UserImpFactor(user) {

    override fun create(): FullOrderClientImp {
        return when (user.role) {
            RoleType.EXECUTOR -> user.toExecutor(feedbackDao.findAll().toList())
            RoleType.CLIENT -> user.toClient(feedbackDao.findAll().toList())
            else -> throw BadParams()
        }
    }

    private fun UserEntity.toExecutor(allFeedbacks: List<FeedbackEntity>) : ExecutorInfo {
        val orders = orderDao.findUserOrders(this.id).toList()
        val portfolio = portfolioDao.user(this.id).toList()

        val myFeedbacks = allFeedbacks.filter { it.user.id == id }
        return ExecutorInfo(
                user = this,
                rate = if (myFeedbacks.isEmpty()) 0f
                else {
                    var num = 0
                    myFeedbacks.forEach { num += it.stars }
                    val stars = num
                    (stars / myFeedbacks.size).toFloat()
                },
                order = UserOrder.create(orders = orders).apply {
                   this.count.declined = run {
                       val canceledExecutorListHis = orderHistoryDao.findAll(id).filter { it.type == OrderHistoryType.CANCEL_EXECUTOR }
                       canceledExecutorListHis.size
                   }
                },
                passport = passportDao.findAll().find { it.user.id == id }?.toInfoJson(),
                portfolioCount = portfolio.size
        ).apply {
            order.enable =
                        isEmailActive &&
                        isPassportActive &&
                        portfolio.isNotEmpty() &&
                        !isBlocked &&
                        city != null &&
                        order.count.open < order.count.max
            if (!order.enable && !isBlocked)
                status = UserStatus.PROCESS
        }
    }

    private fun UserEntity.toClient(allFeedbacks: List<FeedbackEntity>) : ClientInfo {
        val orders = orderDao.findUserOrders(this.id).toList()

        val myFeedbacks = allFeedbacks.filter { it.user.id == id }
        return ClientInfo(
                user = this,
                rate = if (myFeedbacks.isEmpty()) 0f
                else {
                    var num = 0
                    myFeedbacks.forEach { num += it.stars }
                    val stars = num
                    (stars / allFeedbacks.size).toFloat()
                },
                order = UserOrder.create(orders),
                passport = passportDao.findAll().find { it.user.id == id }?.toInfoJson()
        ).apply {
            order.enable = true
        }
    }

}