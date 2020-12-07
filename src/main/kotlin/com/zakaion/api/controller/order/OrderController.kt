package com.zakaion.api.controller.order

import com.zakaion.api.controller.BaseController
import com.zakaion.api.controller.user.ExecutorController
import com.zakaion.api.controller.user.PartnerController
import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.CityDao
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.AppEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import javax.websocket.server.PathParam

class OrderController(private val orderDao: OrderDao,
                      private val userController: UserController,
                      private val feedbackDao: FeedbackDao,
                      private val userDao: UserDao,
                      private val executorController: ExecutorController,
                      private val partnerController: PartnerController,
                      private val cityDao: CityDao,
                      private val userFactory: UserFactory) : BaseController() {

    @PostMapping("/add")
    fun add(@RequestBody addOrderModel: AddOrderModel) : DataResponse<Nothing?> {
        val myUser = userController.getReal().data.let {
            when (it.role) {
                RoleType.EXECUTOR -> {
                    val executorInfo = (it as ExecutorInfo)

                    if (!executorInfo.order.enable)
                        throw NoPermittedMethod()

                    return@let executorInfo.user
                }
                RoleType.PARTNER -> {
                    val partnerInfo = (it as PartnerInfo)

                    if (!partnerInfo.order.enable)
                        throw NoPermittedMethod()

                    return@let partnerInfo.user
                }
                else -> return@let (it as UserEntity)
            }
        }

        if (addOrderModel.content.isEmpty ||
                addOrderModel.dateLine.isEmpty ||
                addOrderModel.title.isEmpty ||
                addOrderModel.price <= 0)
            throw BadParams()

        val city = cityDao.findById(addOrderModel.cityID).orElseGet {
            throw NotFound()
        }

        if (myUser.role != RoleType.CLIENT &&
                (addOrderModel.clientEmail.isEmpty ||
                        addOrderModel.clientPhone.isEmpty ||
                        addOrderModel.clientFirstName.isEmpty ||
                        addOrderModel.clientLastName.isEmpty ||
                        addOrderModel.clientMiddleName.isEmpty))
            throw BadParams()

        val client: UserEntity = if (myUser.role == RoleType.CLIENT)
            myUser
        else {
            userDao.findAll()
                    .find { it.phoneNumber == addOrderModel.clientPhone ||
                            it.email == addOrderModel.clientEmail }
                    ?: userDao.save(UserEntity(
                            email = addOrderModel.clientEmail,
                            phoneNumber = addOrderModel.clientPhone,
                            firstName = addOrderModel.clientFirstName,
                            lastName = addOrderModel.clientLastName,
                            middleName = addOrderModel.clientMiddleName
                    ))
        }

        val executor: UserEntity? = when {
            myUser.role == RoleType.EXECUTOR -> myUser
            addOrderModel.executorID != null -> {
                val fUser = executorController.executor(addOrderModel.executorID).data

                if (!fUser.order.enable)
                    throw BadParams()

                fUser.user
            }
            else -> null
        }

        val orderEntity = orderDao.save(
                OrderEntity(
                        title = addOrderModel.title,
                        content = addOrderModel.content,
                        price = addOrderModel.price,
                        dateLine = addOrderModel.dateLine,
                        client = client,
                        executor = executor,
                        partner = if (myUser.role == RoleType.PARTNER) myUser else null,
                        city = city
                )
        )

        orderDao
                .save(orderEntity)

        if (executor != null) {
            //TODO(Send notification to executor)
        }

        if (myUser.role == RoleType.PARTNER) {
            //TODO(Send notification to partner)
        }

        //TODO(Send notification to client)

        return DataResponse.ok(null)
    }

    @GetMapping("/{id}")
    fun order(@PathParam("id") id: Long) : DataResponse<OrderNModel> {
        val myUser = userController.get().data

        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (order.status != OrderStatus.PROCESS) {
            if (myUser.id !in arrayOf(
                            order.client.id,
                            order.executor?.id,
                            order.partner?.id,
                            order.executor?.masterID))
                throw NoPermittedMethod()
        }

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


        return DataResponse.ok(mOrder)
    }

}