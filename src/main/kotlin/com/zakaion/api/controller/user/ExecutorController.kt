package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.*
import com.zakaion.api.exception.*
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.SmsService
import com.zakaion.api.service.StorageService
import com.zakaion.api.unit.ImportExcellService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["executor"])
class ExecutorController (private val userDao: UserDao,
                          private val authTokenService: AuthTokenService,
                          private val userController: UserController,
                          private val feedbackDao: FeedbackDao,
                          private val orderDao: OrderDao,
                          private val smsService: SmsService,
                          private val userFactory: UserFactory,
                          private val storageService: StorageService,
                          private val importExcellService: ImportExcellService
) : BaseController(){

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
    fun list(pageable: Pageable,
             @RequestParam("search", required = false, defaultValue = "") search: String) : DataResponse<Page<ExecutorInfo>> {
        val myUser = userController.get().data

        val data = if (myUser.role == RoleType.PARTNER) {
            userDao.findByRole(RoleType.EXECUTOR.ordinal, myUser.id, search, pageable)
        }
        else {
            userDao.findByRole(RoleType.EXECUTOR.ordinal, search, pageable)
        }
            .map {user->
                userFactory.create(user) as ExecutorInfo
            }

        return DataResponse.ok(
                data
        )
    }

    @GetMapping("/list/partner/{id}")
    fun listPartner(
        @PathVariable("id") id: Long,
        pageable: Pageable,
        @RequestParam("search", required = false, defaultValue = "null") search: String
    ) : DataResponse<Page<ExecutorInfo>> {
        val data = userDao.findByRole(RoleType.EXECUTOR.ordinal, id, search, pageable).map {user->
                    userFactory.create(user) as ExecutorInfo
                }

        return DataResponse.ok(
                data
        )
    }

    @GetMapping("/{id}")
    fun executor(@PathVariable("id") id: Long) : DataResponse<ExecutorInfo> {
        val user = userDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(
                userFactory.create(user) as ExecutorInfo
        )
    }

    @DeleteMapping("/{id}")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor_Partner)
    fun delete(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val myUser = userController.get().data

        val user = userDao.findById(id).orElseGet { throw NotFound() }
        if (user.role != RoleType.EXECUTOR) throw NotFound()
        if (myUser.role == RoleType.PARTNER && user.masterID != myUser.masterID) throw NoPermittedMethod()

        userDao.delete(user)

        return DataResponse.ok(null)
    }

    @PostMapping("/add")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor_Partner)
    fun add(@RequestBody userEntity: UserEntity): DataResponse<Nothing?> {
        val myUser = userController.get().data

        if (userEntity.phoneNumber.isNullOrEmpty() || userEntity.email.isNullOrEmpty())
            throw BadParams()

        if (userDao.findAll().any { it.phoneNumber == userEntity.phoneNumber || it.email == userEntity.email }) {
            throw AlreadyTaken()
        }

        userDao.save(
                userEntity.copy(
                        role = RoleType.EXECUTOR,
                        masterID = if (myUser.role == RoleType.PARTNER) myUser.id else null
                )
        )

        return DataResponse.ok(
                null
        )
    }

    @PostMapping("/import/{filename:.+}")
    suspend fun import(@PathVariable filename: String) : DataResponse<Nothing?> = withContext(Dispatchers.IO) {
        val inputStream = storageService.loadAsFile(filename).inputStream()

        importExcellService.processUser(inputStream, RoleType.EXECUTOR)

        return@withContext DataResponse.ok(null)
    }
}