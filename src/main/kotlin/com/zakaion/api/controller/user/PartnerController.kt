package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.*
import com.zakaion.api.exception.AlreadyTaken
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.SmsService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["partner"])
class PartnerController (private val userDao: UserDao,
                         private val authTokenService: AuthTokenService,
                         private val userController: UserController,
                         private val smsService: SmsService,
                         private val orderDao: OrderDao,
                         private val userFactory: UserFactory) : BaseController() {

    @GetMapping("/list")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun list(pageable: Pageable, @RequestParam("search", required = false, defaultValue = "") search: String? = null) : DataResponse<Page<PartnerInfo>> {

        val data = (
                if (search.isNullOrEmpty()) userDao.findByRole(RoleType.PARTNER.ordinal, pageable)
                else userDao.findByRole(RoleType.PARTNER.ordinal, search, pageable)
                ).map {user->
                    userFactory.create(user) as PartnerInfo
                }

        return DataResponse.ok(
                data
        )
    }

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
                role = RoleType.PARTNER,
                isPhoneActive = true,
                status = UserStatus.PROCESS
        )

        user = userDao.save(user)

        return DataResponse.ok(
                TokenModel(
                        authTokenService.generateToken(user)
                )
        )
    }

    @DeleteMapping("/{id}")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun delete(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }
        if (user.role != RoleType.PARTNER) throw NotFound()

        userDao.delete(user)

        return DataResponse.ok(null)
    }

    @PostMapping("/add")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun add(@RequestBody userEntity: UserEntity): DataResponse<Nothing?> {
        val myUser = userController.get().data

        if (userEntity.phoneNumber.isNullOrEmpty() || userEntity.email.isNullOrEmpty())
            throw BadParams()

        if (userDao.findAll().any { it.phoneNumber == userEntity.phoneNumber || it.email == userEntity.email }) {
            throw AlreadyTaken()
        }

        userDao.save(
                userEntity.copy(
                        role = RoleType.PARTNER,
                        status = UserStatus.PROCESS
                )
        )

        return DataResponse.ok(
                null
        )
    }
}