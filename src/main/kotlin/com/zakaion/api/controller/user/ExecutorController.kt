package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.FeedbackEntity
import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.OrderStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp
import com.zakaion.api.exception.AlreadyTaken
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.model.*
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor_Partner
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.SmsService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["executor"])
class ExecutorController (private val userDao: UserDao,
                          private val authTokenService: AuthTokenService,
                          private val userController: UserController,
                          private val feedbackDao: FeedbackDao,
                          private val orderDao: OrderDao,
                          private val smsService: SmsService) : BaseController(){

    @PostMapping("/register/phone")
    fun registerPhone(@RequestBody phoneRegister: PhoneRegister) : DataResponse<TokenModel> {
        if (userDao.findAll().any { it.phoneNumber == phoneRegister.phoneNumber })
            throw AlreadyTaken()

        if (phoneRegister.token != null && phoneRegister.smsCode != null) {
            val phoneSms = authTokenService.parsePhoneToken(phoneRegister.token) ?: throw WrongPassword()
            if (phoneSms.second != phoneRegister.smsCode) throw WrongPassword()

            return DataResponse.ok(
                    TokenModel(
                            authTokenService.generatePhoneToken(phoneRegister.phoneNumber!!, "null")
                    )
            )
        }

        val code = "1234"

        smsService.sendCode(phoneNumber = phoneRegister.phoneNumber!!, code = code)

        return DataResponse.ok(
                TokenModel(
                        authTokenService.generatePhoneToken(phoneRegister.phoneNumber, code)
                )
        )
    }

    @PostMapping("/register")
    fun register(@RequestBody userEntity: UserEntity,
                 @RequestHeader("token") token: String) : DataResponse<TokenModel> {

        val phoneNumber = authTokenService.parsePhoneToken(token)?.first ?: throw WrongPassword()

        if (userDao.findAll().any { it.phoneNumber == phoneNumber || it.email == userEntity.email }) {
            throw AlreadyTaken()
        }

        var user = userEntity.copy(
                phoneNumber = phoneNumber,
                role = RoleType.EXECUTOR,
                isPhoneActive = true
        )

        user = userDao.save(user)

        return DataResponse.ok(
                TokenModel(
                        authTokenService.generateToken(user)
                )
        )
    }

    @GetMapping("/list")
    fun list(pageable: Pageable) : DataResponse<Page<ExecutorInfo>> {
        val myUser = userController.get().data

        val orders = orderDao.findAll().toList()

        val feedbacks = feedbackDao.findAll().toList()

        val data = userDao.findByRole(RoleType.EXECUTOR.ordinal, pageable).map {user->
            user.toExecutor(myUser, feedbacks, orders)
        }

        return DataResponse.ok(
                data
        )
    }

    @GetMapping("/{id}")
    fun executor(@PathVariable("id") id: Long) : DataResponse<ExecutorInfo> {
        val myUser = userController.get().data

        val orders = orderDao.findAll().toList()

        val feedbacks = feedbackDao.findAll().toList()

        val user = userDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(
                user.toExecutor(myUser, feedbacks, orders)
        )
    }

    @DeleteMapping("/{id}")
    @CanSuperAdmin_Admin_Editor_Partner
    fun delete(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val myUser = userController.get().data

        val user = userDao.findById(id).orElseGet { throw NotFound() }
        if (user.role != RoleType.EXECUTOR) throw NotFound()
        if (myUser.role == RoleType.PARTNER && user.masterID != myUser.masterID) throw NoPermittedMethod()

        userDao.delete(user)

        return DataResponse.ok(null)
    }

    @PostMapping("/add")
    @CanSuperAdmin_Admin_Editor_Partner
    fun add(@RequestBody userEntity: UserEntity): DataResponse<UserEntity> {
        val myUser = userController.get().data

        if (userDao.findAll().any { it.phoneNumber == userEntity.phoneNumber || it.email == userEntity.email }) {
            throw AlreadyTaken()
        }

        return DataResponse.ok(
                userDao.save(
                        userEntity.copy(
                                role = RoleType.EXECUTOR,
                                masterID = if (myUser.role == RoleType.PARTNER) myUser.id else null
                        )
                )
        )
    }
}

fun UserImp.viewHideContacts(myUser: UserEntity?,
                             allOrders: List<OrderEntity>) {
    val user = this

    if (myUser?.role in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR) ||
            user.id == myUser?.id ||
            user.masterID == myUser?.id)
        return

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

fun UserEntity.toExecutor(myUser: UserEntity?,
                          allFeedbacks: List<FeedbackEntity>,
                          allOrders: List<OrderEntity>) : ExecutorInfo {

    if (this.role != RoleType.EXECUTOR)
        throw NotFound()

    return ExecutorInfo(
            user = this,
            rate = {
                val myFeedbacks = allFeedbacks.filter { it.user.id == this.id }
                if (myFeedbacks.isEmpty()) 0f
                else {
                    val stars = {
                        var num = 0
                        myFeedbacks.forEach { num += it.stars }
                        num
                    }.invoke()
                    (stars / allFeedbacks.size).toFloat()
                }
            }.invoke(),
            order = UserOrder.create(allOrders.filter { it.executor?.id == this.id }).apply {
                if (this.enable) {
                    this.enable = this@toExecutor.isPassportActive && this@toExecutor.isEmailActive && this@toExecutor.isPassportActive
                }
            }
    ).apply {
        viewHideContacts(myUser, allOrders)
    }
}