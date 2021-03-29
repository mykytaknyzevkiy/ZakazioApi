package com.zakaion.api.controller.order

import com.zakaion.api.controller.BaseController
import com.zakaion.api.controller.history.OrderHistoryController
import com.zakaion.api.controller.user.ExecutorController
import com.zakaion.api.controller.user.PartnerController
import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.*
import com.zakaion.api.entity.history.OrderHistoryType
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.OrderFactor
import com.zakaion.api.factor.UserFull
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.service.*
import com.zakaion.api.unit.ImportExcellService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile

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
                      private val tokenService: AuthTokenService,
                      private val transactionService: TransactionService,
                      private val storageService: StorageService,
                      private val categoryDao: CategoryDao,
                      private val importExcellService: ImportExcellService,
                      private val historyController: OrderHistoryController,
                      private val childCategoryDao: ChildCategoryDao,
                      private val socketService: SocketService
                      ) : BaseController() {

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
                RoleType.CLIENT -> {
                    return@let (it as ClientInfo).user
                }
                else -> return@let (it as UserFull).user
            }
        }

        if (addOrderModel.content.isEmpty() ||
                addOrderModel.dateLine.isEmpty() ||
                addOrderModel.title.isEmpty()
            ||
                addOrderModel.price <= 0)
            throw BadParams()

        val city = cityDao.findById(addOrderModel.cityID).orElseGet {
            throw NotFound()
        }

        if (myUser.role != RoleType.CLIENT &&
                (addOrderModel.clientEmail.isNullOrEmpty() ||
                        addOrderModel.clientPhone.isNullOrEmpty() ||
                        addOrderModel.clientFirstName.isNullOrEmpty() ||
                        addOrderModel.clientLastName.isNullOrEmpty() ||
                        addOrderModel.clientMiddleName.isNullOrEmpty()))
            throw BadParams()

        val client: UserEntity = if (myUser.role == RoleType.CLIENT)
            myUser
        else {
            userDao.findAll()
                    .find { it.phoneNumber == addOrderModel.clientPhone ||
                            it.email == addOrderModel.clientEmail && it.role == RoleType.CLIENT}
                    ?: userDao.save(UserEntity(
                            email = addOrderModel.clientEmail,
                            phoneNumber = addOrderModel.clientPhone,
                            firstName = addOrderModel.clientFirstName,
                            lastName = addOrderModel.clientLastName,
                            middleName = addOrderModel.clientMiddleName
                    ).apply {
                        if (myUser.role == RoleType.PARTNER)
                            this.masterID = myUser.id
                    })
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

        val childCategory = childCategoryDao.findById(addOrderModel.categoryID).orElseGet {
            throw NotFound()
        }

        if (!childCategory.parent.isActive)
            throw BadParams()

        val orderEntity = orderDao.save(
                OrderEntity(
                        title = addOrderModel.title,
                        content = addOrderModel.content,
                        price = addOrderModel.price,
                        dateLine = addOrderModel.dateLine,
                        client = client,
                        executor = executor,
                        partner = if (myUser.role == RoleType.PARTNER) myUser else null,
                        city = city,
                        files = addOrderModel.files,
                        category = childCategory.parent,
                        childCategory = childCategory
                )
        )

        notificationService.onCreateOrder(orderEntity)

        historyController.add(orderEntity, myUser, OrderHistoryType.CREATE)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/edit")
    fun edit(@PathVariable("id") id: Long, @RequestBody editOrderModel: EditOrderModel) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val orderInfo = orderFactor.create(order.copy())

        if (!orderInfo.editEnable)
            throw NoPermittedMethod()

        orderDao.save(
                order.copy(
                        title = editOrderModel.title,
                        content = editOrderModel.content,
                        price = editOrderModel.price,
                        files = editOrderModel.files
                )
        )

        historyController.add(order, userFactory.myUser, OrderHistoryType.EDIT)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/edit/add/file")
    fun addFile(@PathVariable("id") id: Long, @RequestParam("file") file: MultipartFile) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val orderInfo = orderFactor.create(order.copy())

        if (!orderInfo.editEnable)
            throw NoPermittedMethod()

        val files = arrayListOf<String>().apply {
            addAll(order.files)
            add(
                    storageService.store(file)
            )
        }

        orderDao.save(
                order.copy(
                        files = files
                )
        )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/edit/remove/file/{filename:.+}")
    fun removeFile(@PathVariable("id") id: Long, @PathVariable filename: String) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val orderInfo = orderFactor.create(order.copy())

        if (!orderInfo.editEnable)
            throw NoPermittedMethod()

        if (!orderInfo.files.contains(filename))
            throw BadParams()

        storageService.delete(filename)

        val files = arrayListOf<String>().apply {
            addAll(order.files)
            remove(filename)
        }

        orderDao.save(
                order.copy(
                        files = files
                )
        )

        return DataResponse.ok(null)
    }

    @GetMapping("/{id}/info")
    fun order(@PathVariable("id") id: Long) : DataResponse<OrderNModel> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(orderFactor.create(order.copy()))
    }

    @GetMapping("/list")
    fun list(pageable: Pageable,
             @RequestParam(
                     "search",
                     required = false,
                     defaultValue = ""
             ) search: String,
             @RequestParam(
                 "city_id",
                 required = false,
                 defaultValue = "-1"
             ) cityID: Long = -1,
             @RequestParam(
                 "category_id",
                 required = false,
                 defaultValue = "-1"
             ) categoryID: Long = -1,
             @RequestParam(
                 "child_category_id",
                 required = false,
                 defaultValue = "-1"
             ) childCategoryID: Long = -1) : DataResponse<Page<OrderNModel>> {


        return DataResponse.ok(
            (if (userFactory.myUser.role == RoleType.EXECUTOR || userFactory.myUser.role == RoleType.PARTNER)
                orderDao.findFreeAll(pageable, search, cityID, categoryID, childCategoryID)
            else
                orderDao.findAll(pageable, search, cityID, categoryID, childCategoryID))
                .map {
                            orderFactor.create(it.copy())
                        }
        )
    }

    @GetMapping("/list/user/{userID}")
    fun list(pageable: Pageable,
             @PathVariable("userID") userID: Long,
             @RequestParam(
                     "search",
                     required = false,
                     defaultValue = ""
             ) search: String) : DataResponse<Page<OrderNModel>> {
        return DataResponse.ok(
            orderDao.findUserOrders(pageable, userID, search)
                        .map {
                            orderFactor.create(it.copy())
                        }
        )
    }

    @GetMapping("/list/app/{appID}")
    fun listApp(pageable: Pageable,
             @PathVariable("appID") appID: Long) : DataResponse<Page<OrderNModel>> {
        return DataResponse.ok(
            orderDao.findAppOrders(pageable, appID)
                .map {
                    orderFactor.create(it.copy())
                }
        )
    }

    @PutMapping("/{id}/be/executor")
    fun beExecutor(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order.copy())

        if (!mOrder.beExecutorEnable)
            throw BadParams()

        val myUser = userFactory.myUser

        setExecutor(id, myUser.id)

        historyController.add(order, myUser, OrderHistoryType.BE_EXECUTOR)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/executor/{executorID}")
    fun setExecutor(@PathVariable("id") id: Long,
                    @PathVariable("executorID") executorID: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order.copy())

        if (!mOrder.setExecutorEnable && !mOrder.beExecutorEnable)
            throw BadParams()

        if (!mOrder.cancelExecutorEnable && mOrder.executor != null)
            throw BadParams()

        if (order.executor != null)
            cancelExecutor(id)

        val executorDB = userDao.findById(executorID).orElseGet {
            throw NotFound()
        }

        val executor = userFactory.create(executorDB.copy()) as ExecutorInfo

        if (!executor.order.enable)
            throw NoPermittedMethod()

        val nOrder = orderDao.save(
                order.copy(
                        executor = executorDB
                )
        )

        notificationService.onYouOrderExecutor(nOrder)

        notificationService.onClientHasExecutorOrder(nOrder)

        historyController.add(order, userFactory.myUser, OrderHistoryType.SET_EXECUTOR)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/cancel/executor")
    fun cancelExecutor(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order.copy())

        if (!mOrder.cancelExecutorEnable && !mOrder.defuseMeExecutorEnable)
            throw NoPermittedMethod()

        orderDao.save(
                order.copy(
                        status = OrderStatus.PROCESS,
                        executor = null
                )
        )

        historyController.add(order, userFactory.myUser, OrderHistoryType.CANCEL_EXECUTOR)

        if (userFactory.myUser.id == order.executor?.id) {
            val executor = userFactory.create(order.executor) as ExecutorInfo
            if (executor.order.count.declined % 4 == 0) {
                userDao.save(
                    executor.user.copy(
                        isBlocked = true
                    )
                )
            }
        }

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/status/work")
    fun setInWork(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order.copy())

        if (!mOrder.inWorkEnable)
            throw BadParams()

        orderDao
                .save(
                        order.copy(status = OrderStatus.IN_WORK)
                )

        notificationService.onClientOrderInWork(order)

        historyController.add(order, userFactory.myUser, OrderHistoryType.START_WORK)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/status/done")
    fun setDone(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order.copy())

        if (!mOrder.doneEnable)
            throw BadParams()

        orderDao
                .save(
                        order.copy(status = OrderStatus.DONE)
                )

        notificationService.addClientFeedback(order)
        notificationService.addExecutorFeedback(order)

        historyController.add(order, userFactory.myUser, OrderHistoryType.DONE_WORK)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/set/status/cancel")
    fun setCancel(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        val mOrder = orderFactor.create(order.copy())

        if (!mOrder.cancelEnable)
            throw BadParams()

        orderDao
                .save(
                        order.copy(status = OrderStatus.CANCEL)
                )

        historyController.add(order, userFactory.myUser, OrderHistoryType.CANCEL)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/share/sum/{amount}")
    fun shareSum(@PathVariable("id") id: Long,
                 @PathVariable("amount") amountM: Float) : DataResponse<Nothing?> {
        var amount = amountM

        val order = orderDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (userFactory.myUser.id != order.executor?.id)
            throw NoPermittedMethod()

        val orderFull = orderFactor.create(order)

        if (amount > orderFull.toShareSum)
            amount = orderFull.toShareSum

        transactionService.processOrder(order, amount)

        historyController.add(order, userFactory.myUser, OrderHistoryType.SHARE_SUM)

        return DataResponse.ok(null)
    }

    @PostMapping("/import/{filename:.+}")
    fun import(@PathVariable filename: String) : DataResponse<Nothing?> {
        val inputStream = storageService.loadAsFile(filename).inputStream()

        GlobalScope.launch(Dispatchers.IO) {
            importExcellService.processOrder(inputStream)
        }

        return DataResponse.ok(null)
    }

    @PostMapping("/test")
    suspend fun test() : DataResponse<Nothing?> {
        socketService.importOrderProcess(0, 10)

        return DataResponse.ok(null)
    }

}