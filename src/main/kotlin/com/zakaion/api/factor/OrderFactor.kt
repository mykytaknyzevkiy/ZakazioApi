package com.zakaion.api.factor

import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.ClientInfo
import com.zakaion.api.model.ExecutorInfo
import com.zakaion.api.model.OrderNModel
import com.zakaion.api.model.PartnerInfo
import org.springframework.stereotype.Service

@Service
class OrderFactor(private val userFactory: UserFactory) : MFactor(){

    fun create(order: OrderEntity) : OrderNModel {
        /*if (order.status != OrderStatus.PROCESS) {
            if (myUser.id !in arrayOf(
                            order.client.id,
                            order.executor?.id,
                            order.partner?.id,
                            order.executor?.masterID))
                throw NoPermittedMethod()
        }*/

        val mOrder = OrderNModel(
                id = order.id,

                status = order.status,

                title = order.title,
                content = order.content,
                price = order.price,
                dateLine = order.dateLine,

                city = order.city,

                client = userFactory.create(order.client) as ClientInfo,
                executor = userFactory.create(order.executor) as ExecutorInfo,
                partner = userFactory.create(order.partner) as PartnerInfo,

                app = order.app
        )

        when (myUser.id) {
            order.client.id -> {
                mOrder.apply {
                    editEnable = order.partner == null
                    cancelExecutorEnable = order.partner == null
                    cancelEnable = order.partner == null
                }
            }
            order.executor?.id -> {
                mOrder.apply {
                    editEnable = order.partner == null
                    cancelExecutorEnable = true
                    inWorkEnable = true
                    cancelEnable = order.partner == null
                }
            }
            order.partner?.id -> {
                mOrder.apply {
                    editEnable = true
                    cancelExecutorEnable = true
                    inWorkEnable = false
                    cancelEnable = true
                }
            }
            order.executor?.masterID -> {
                mOrder.apply {
                    setExecutorEnable = true
                    cancelExecutorEnable = true
                    inWorkEnable = false
                    cancelEnable = false
                }
            }
            else -> {
                val data = myUser.role in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR)
                mOrder.apply {
                    editEnable = data
                    beExecutorEnable = data
                    setExecutorEnable = data
                    cancelExecutorEnable = data
                    inWorkEnable = data
                    doneEnable = data
                    cancelEnable = data
                }
            }
        }

        if (mOrder.executor == null) {
            mOrder.beExecutorEnable = myUser.role == RoleType.EXECUTOR && (userFactory.create(myUser) as ExecutorInfo).order.enable
            mOrder.setExecutorEnable = myUser.role == RoleType.PARTNER
        }

        when (mOrder.status) {
            OrderStatus.DONE -> {
                mOrder.cancelEnable = false
                mOrder.cancelExecutorEnable = false
                mOrder.editEnable = false
            }
            OrderStatus.IN_WORK -> {
                mOrder.editEnable = false
            }
            OrderStatus.CANCEL -> {
                mOrder.apply {
                    editEnable = false
                    beExecutorEnable = false
                    setExecutorEnable = false
                    cancelExecutorEnable = false
                    inWorkEnable = false
                    doneEnable = false
                    cancelEnable = false
                }
            }
        }

        if (mOrder.status == OrderStatus.PROCESS && myUser.id == order.executor?.id) {
            mOrder.inWorkEnable = true
        }

        return mOrder
    }

}