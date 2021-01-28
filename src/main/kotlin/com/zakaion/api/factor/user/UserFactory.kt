package com.zakaion.api.factor.user

import com.zakaion.api.dao.*
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp
import com.zakaion.api.factor.MFactor
import com.zakaion.api.factor.UserFullImp
import org.springframework.stereotype.Service

@Service
class UserFactory(private val orderDao: OrderDao,
                  private val feedbackDao: FeedbackDao,
                  private val passportDao: PassportDao,
                  private val requestPassportDao: RequestPassportDao,
                  private val portfolioDao: PortfolioDao) : MFactor() {

    fun create(user: UserEntity?): UserImp? {
        if (user == null)
            return null
        return buildFactor(user)
                .create().apply {
                    viewHideContacts(myUser)
                    if (!this.isPassportActive)
                        this.passportInProgress = requestPassportDao.findAll().any { it.user.id == this.user.id }
                }
    }

    private fun buildFactor(user: UserEntity) : UserImpFactor {
        return if (user.role == RoleType.CLIENT || user.role == RoleType.EXECUTOR)
            FullOrderClientFactor(user, orderDao, feedbackDao, passportDao, portfolioDao)
        else if (user.role == RoleType.PARTNER)
            ManagerOrderFactory(user, orderDao, passportDao)
        else
            ZakazioUserFactory(user, passportDao)
    }

    private fun UserFullImp.viewHideContacts(myUser: UserEntity?) {

        if (myUser?.role in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            return
        else if (this.id == myUser?.id || this.masterID == myUser?.id)
            return

        this.passport = null

        if (orderDao.findFriendOrders(this.id, myUser?.id?:return).toList().isNotEmpty()) {
            return
        }

        this.apply {
            phoneNumber = null
            email = null
        }
    }

}