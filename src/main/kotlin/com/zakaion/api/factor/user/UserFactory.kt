package com.zakaion.api.factor.user

import com.zakaion.api.factor.UserFullImp
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp
import com.zakaion.api.factor.MFactor
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Service

@Service
class UserFactory(private val orderDao: OrderDao,
                  private val feedbackDao: FeedbackDao,
                  private val passportDao: PassportDao) : MFactor() {

    fun create(user: UserEntity?): UserImp? {
        if (user == null)
            return null
        return buildFactor(user)
                .create().apply {
                    viewHideContacts(myUser, orderDao.findAll().toList())
                }
    }

    private fun buildFactor(user: UserEntity) : UserImpFactor {
        return if (user.role == RoleType.CLIENT || user.role == RoleType.EXECUTOR)
            FullOrderClientFactor(user, orderDao, feedbackDao, passportDao)
        else if (user.role == RoleType.PARTNER)
            ManagerOrderFactory(user, orderDao, passportDao)
        else
            ZakazioUserFactory(user, passportDao)
    }

    private fun UserFullImp.viewHideContacts(myUser: UserEntity?,
                                                                                       allOrders: List<OrderEntity>) {
        val user = this

        if (myUser?.role in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR) ||
                user.id == myUser?.id ||
                user.masterID == myUser?.id)
            return

        this.passport = null

        val orders = allOrders
                .filter {
                    user.id in arrayOf(
                            it.executor?.id,
                            it.app?.masterID,
                            it.client.id,
                            it.partner?.id
                    ) &&
                            it.status !in arrayOf(
                            OrderStatus.DONE,
                            OrderStatus.CANCEL
                    )
                }

        if (orders.any {(myUser?.id?:-1000) in arrayOf(
                        it.executor?.id,
                        it.app?.masterID,
                        it.client.id,
                        it.partner?.id) })
            return


        this.apply {
            phoneNumber = null
            email = null
        }

    }

}