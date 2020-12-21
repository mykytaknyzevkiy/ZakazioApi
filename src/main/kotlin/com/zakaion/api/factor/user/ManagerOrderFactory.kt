package com.zakaion.api.factor.user

import com.zakaion.api.factor.ManagerUserImp
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.PartnerInfo
import com.zakaion.api.model.UserOrder

class ManagerOrderFactory(
        user: UserEntity,
        private val orderDao: OrderDao,
        private val passportDao: PassportDao
) : UserImpFactor(user) {

    override fun create(): ManagerUserImp {
        return when (user.role) {
            RoleType.PARTNER -> user.toPartner()
            else -> throw BadParams()
        }
    }

    private fun UserEntity.toPartner() : PartnerInfo {
        val orders = orderDao.findUserOrders(this.id).toList()

        if (this.role != RoleType.PARTNER)
            throw NotFound()

        return PartnerInfo(
                user = this,
                order = UserOrder.create(orders).apply {
                    this.enable = this@toPartner.isPassportActive && this@toPartner.isEmailActive && this@toPartner.isPassportActive
                },
                passport = passportDao.findAll().find { it.user.id == this.id }
        )
    }

}