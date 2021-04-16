package com.zakaion.api.factor

import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.ClientInfo
import com.zakaion.api.model.ExecutorInfo
import com.zakaion.api.model.OrderNModel
import com.zakaion.api.model.PartnerInfo
import com.zakaion.api.service.Preference
import com.zakaion.api.service.TransactionService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.withContext
import org.springframework.stereotype.Service

@Service
class OrderFactor(private val userFactory: UserFactory,
                  private val transactionService: TransactionService,
                  private val orderDao: OrderDao) : MFactor() {

    private val adminsRole = arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR)

    fun create(orderID: Long) : OrderNModel {
        return create(
                orderDao.findById(orderID).orElseGet {
                    throw NotFound()
                }
        )
    }

    fun create(orderM: OrderEntity) : OrderNModel {
        val order = orderM.copy()

        val orderSum = transactionService.orderBalance(order.id)

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

                app = order.app,

                files = order.files,

                toShareSum = ((order.price * Preference.orderSumOutPercent / 100)) - orderSum,

                category = order.category,

                childCategory = order.childCategory
        )

        val adminsRole = arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR)

        mOrder.editEnable = order.status == OrderStatus.PROCESS &&
                (myUser.role in adminsRole ||
                        myUser.id in arrayOf(order.client.id, order.partner?.id))

        mOrder.beExecutorEnable = order.executor == null &&
                myUser.role == RoleType.EXECUTOR &&
                mOrder.status == OrderStatus.PROCESS &&
                (userFactory.create(myUser) as ExecutorInfo).order.enable

        mOrder.setExecutorEnable = mOrder.status == OrderStatus.PROCESS &&
                order.executor == null &&
                (myUser.role in adminsRole ||
                        (myUser.role == RoleType.PARTNER && (userFactory.create(myUser) as PartnerInfo).order.enable) ||
                myUser.id in arrayOf(order.client.id, order.partner?.id))

        mOrder.cancelExecutorEnable = order.status in arrayOf(OrderStatus.PROCESS, OrderStatus.IN_WORK) &&
                (myUser.id in arrayOf(order.client.id, order.partner?.id) || myUser.role in adminsRole) && mOrder.toShareSum >= 0

        mOrder.defuseMeExecutorEnable = order.status in arrayOf(OrderStatus.PROCESS, OrderStatus.IN_WORK) &&
                myUser.id == order.executor?.id && mOrder.toShareSum >= 0

        mOrder.inWorkEnable = order.status == OrderStatus.PROCESS && myUser.id == order.executor?.id

        if (myUser.id == mOrder.executor?.id && order.status == OrderStatus.IN_WORK) {
            mOrder.doneEnable = mOrder.toShareSum <= 0
        }

        if (myUser.role in adminsRole) {
            mOrder.commentEnable = true
        }
        else {
            mOrder.commentEnable = myUser.id in arrayOf(order.client.id, order.partner?.id, order.executor?.id)
        }

        mOrder.cancelEnable = (mOrder.status == OrderStatus.PROCESS && (myUser.role in adminsRole || myUser.id in arrayOf(order.client.id, order.partner?.id)))

        return mOrder
    }

    suspend fun createWork(orderM: OrderEntity, myUser: UserEntity) : OrderNModel = withContext(Dispatchers.IO) {
        val order = orderM.copy()

        val orderSum = async(Dispatchers.IO) {
            transactionService.orderBalance(order.id)
        }

        val mOrder = OrderNModel(
            id = order.id,

            status = order.status,

            title = order.title,
            content = order.content,
            price = order.price,
            dateLine = order.dateLine,

            creationDate = order.creationDateTime,

            city = order.city,

            client = withContext(Dispatchers.IO) { userFactory.createWork(order.client, myUser) as ClientInfo },
            executor = withContext(Dispatchers.IO) { userFactory.createWork(order.executor, myUser) as? ExecutorInfo },
            partner = withContext(Dispatchers.IO) { userFactory.createWork(order.partner, myUser) as? PartnerInfo },

            app = order.app,

            files = order.files,

            toShareSum = ((order.price * Preference.orderSumOutPercent / 100)) - orderSum.await(),

            category = order.category,

            childCategory = order.childCategory
        )

        mOrder.editEnable = order.status == OrderStatus.PROCESS &&
                (myUser.role in adminsRole ||
                        myUser.id in arrayOf(order.client.id, order.partner?.id))

        mOrder.beExecutorEnable = order.executor == null &&
                myUser.role == RoleType.EXECUTOR &&
                mOrder.status == OrderStatus.PROCESS &&
                (userFactory.createWork(myUser, myUser) as ExecutorInfo).order.enable

        mOrder.setExecutorEnable = mOrder.status == OrderStatus.PROCESS &&
                order.executor == null &&
                (myUser.role in adminsRole ||
                        (myUser.role == RoleType.PARTNER && (userFactory.createWork(myUser, myUser) as PartnerInfo).order.enable) ||
                        myUser.id in arrayOf(order.client.id, order.partner?.id))

        mOrder.cancelExecutorEnable = order.status in arrayOf(OrderStatus.PROCESS, OrderStatus.IN_WORK) &&
                (myUser.id in arrayOf(order.client.id, order.partner?.id) || myUser.role in adminsRole) && mOrder.toShareSum >= 0

        mOrder.defuseMeExecutorEnable = order.status in arrayOf(OrderStatus.PROCESS, OrderStatus.IN_WORK) &&
                myUser.id == order.executor?.id && mOrder.toShareSum >= 0

        mOrder.inWorkEnable = order.status == OrderStatus.PROCESS && myUser.id == order.executor?.id

        if (myUser.id == mOrder.executor?.id && order.status == OrderStatus.IN_WORK) {
            mOrder.doneEnable = mOrder.toShareSum <= 0
        }

        if (myUser.role in adminsRole) {
            mOrder.commentEnable = true
        }
        else {
            mOrder.commentEnable = myUser.id in arrayOf(order.client.id, order.partner?.id, order.executor?.id)
        }

        mOrder.cancelEnable = (mOrder.status == OrderStatus.PROCESS && (myUser.role in adminsRole || myUser.id in arrayOf(order.client.id, order.partner?.id)))

        return@withContext mOrder
    }

}