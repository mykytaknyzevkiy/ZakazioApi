package com.zakaion.api.controller.order

import com.zakaion.api.controller.BaseController
import com.zakaion.api.controller.user.ExecutorController
import com.zakaion.api.controller.user.PartnerController
import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.CityDao
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.OrderFactor
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.NotificationService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["order"])
class OrderController(private val orderDao: OrderDao,
                      private val userController: UserController,
                      private val feedbackDao: FeedbackDao,
                      private val userDao: UserDao,
                      private val executorController: ExecutorController,
                      private val partnerController: PartnerController,
                      private val cityDao: CityDao,
                      private val userFactory: UserFactory,
                      private val orderFactor: OrderFactor,
                      private val notificationService: NotificationService,
                      private val tokenService: AuthTokenService) : BaseController() {

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

        notificationService.onCreateOrder(orderEntity)

        return DataResponse.ok(null)
    }

    @GetMapping("/{id}/info")
    fun order(@PathVariable("id") id: Long) : DataResponse<OrderNModel> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(orderFactor.create(order))
    }

    @GetMapping("/list")
    fun list(pageable: Pageable) : DataResponse<Page<OrderNModel>> {
        return DataResponse.ok(
                orderDao.findAll(pageable)
                        .map {
                            orderFactor.create(it)
                        }
        )
    }

    @GetMapping("/list/user/{userID}")
    fun list(pageable: Pageable, @PathVariable("userID") userID: Long) : DataResponse<Page<OrderNModel>> {
        return DataResponse.ok(
                orderDao.findUserOrders(pageable, userID)
                        .map {
                            orderFactor.create(it)
                        }
        )
    }

    @PutMapping("/{id}/be/executor")
    fun beExecutor(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order)

        if (!mOrder.beExecutorEnable)
            throw BadParams()

        val myUser = userFactory.myUser

        val nOrder = orderDao.save(
                order.copy(
                        executor = myUser
                )
        )

        notificationService.onYouOrderExecutor(nOrder)

        notificationService.onClientHasExecutorOrder(nOrder)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/executor/{executorID}")
    fun setExecutor(@PathVariable("id") id: Long,
                    @PathVariable("executorID") executorID: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order)

        if (!mOrder.setExecutorEnable)
            throw BadParams()

        if (!mOrder.cancelExecutorEnable && mOrder.executor != null)
            throw BadParams()

        if (order.executor != null)
            cancelExecutor(id)

        val executor = userFactory.create(
                userDao.findById(executorID).orElseGet {
                    throw NotFound()
                }
        ) as ExecutorInfo

        if (!executor.order.enable)
            throw NoPermittedMethod()

        val nOrder = orderDao.save(
                order.copy(
                        executor = executor.user
                )
        )

        notificationService.onYouOrderExecutor(nOrder)

        notificationService.onClientHasExecutorOrder(nOrder)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/cancel/executor")
    fun cancelExecutor(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order)

        if (!mOrder.cancelExecutorEnable)
            throw NoPermittedMethod()

        val myUser = userFactory.myUser

        val nOrder = orderDao.save(
                order.copy(
                        status = OrderStatus.PROCESS,
                        executor = null
                )
        )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/status/work")
    fun setInWork(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order)

        if (!mOrder.inWorkEnable)
            throw BadParams()

        orderDao
                .save(
                        order.copy(status = OrderStatus.IN_WORK)
                )

        notificationService.onClientOrderInWork(order)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/status/done")
    fun setDone(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order)

        if (!mOrder.doneEnable)
            throw BadParams()

        orderDao
                .save(
                        order.copy(status = OrderStatus.DONE)
                )

        notificationService.addClientFeedback(order)
        notificationService.addExecutorFeedback(order)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/status/cancel")
    fun setCancel(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order)

        if (!mOrder.cancelEnable)
            throw BadParams()

        orderDao
                .save(
                        order.copy(status = OrderStatus.CANCEL)
                )

        return DataResponse.ok(null)
    }

}