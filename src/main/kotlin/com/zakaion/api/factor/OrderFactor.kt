package com.zakaion.api.factor

import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.ClientInfo
import com.zakaion.api.model.ExecutorInfo
import com.zakaion.api.model.OrderNModel
import com.zakaion.api.model.PartnerInfo
import com.zakaion.api.service.Preference
import com.zakaion.api.service.TransactionService
import org.springframework.stereotype.Service

@Service
class OrderFactor(private val userFactory: UserFactory,
                  private val transactionService: TransactionService) : MFactor(){

    fun create(order: OrderEntity) : OrderNModel {
        val mOrder = OrderNModel(
                id = order.id,

                status = order.status,

                title = order.title,
                content = order.content,
                price = order.price,
                dateLine = order.dateLine,

                creationDate = order.creationDateTime,

                city = order.city,

                client = userFactory.create(order.client) as ClientInfo,
                executor = userFactory.create(order.executor) as? ExecutorInfo,
                partner = userFactory.create(order.partner) as? PartnerInfo,

                app = order.app
        )

        val adminsRole = arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR)

        mOrder.editEnable = order.status == OrderStatus.PROCESS &&
                (myUser.role in adminsRole ||
                        myUser.id in arrayOf(order.client.id, order.partner?.id))

        mOrder.beExecutorEnable = order.executor == null &&
                myUser.role == RoleType.EXECUTOR &&
                (userFactory.create(myUser) as ExecutorInfo).order.enable

        mOrder.setExecutorEnable = order.executor == null &&
                (myUser.role in adminsRole ||
                myUser.role == RoleType.PARTNER ||
                myUser.id in arrayOf(order.client.id, order.partner?.id))

        mOrder.cancelExecutorEnable = order.status in arrayOf(OrderStatus.PROCESS, OrderStatus.IN_WORK) &&
                myUser.id in arrayOf(order.client.id, order.executor?.id, order.partner?.id)

        mOrder.inWorkEnable = order.status == OrderStatus.PROCESS && myUser.id == order.executor?.id

        if (myUser.id == mOrder.executor?.id) {
            val orderSum = transactionService.orderBalance(mOrder.id)

            mOrder.doneEnable = orderSum >= (mOrder.price * Preference.orderSumOutPercent / 100)
        }

        return mOrder
    }

}