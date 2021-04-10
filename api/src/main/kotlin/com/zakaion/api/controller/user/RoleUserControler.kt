package com.zakaion.api.controller.user

import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.EmailRegister
import com.zakaion.api.model.TokenModel
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.EmailService
import com.zakaion.api.service.NotificationService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RestController

@RestController
abstract class RoleUserController(private val userDao: UserDao,
                                  private val authTokenService: AuthTokenService,
                                  private val emailService: EmailService) {

    abstract val roleType: RoleType

    @PostMapping("/register/step/1")
    fun registerStep1(@RequestBody body: EmailRegister): DataResponse<TokenModel> {
        print("on registerStep1")
        if (body.email.isNullOrEmpty())
            throw BadParams()

        if (userDao.findAll().any { it.email == body.email }) {
            throw BadParams()
        }

        val code = authTokenService.generateAuthCode()

        emailService.sendVerificationCode(body.email, code)

        val token = authTokenService.generatePhoneToken(body.email, code)

        return DataResponse.ok(
            TokenModel((token))
        )
    }

    @PostMapping("/register/step/2")
    fun registerStep2(@RequestBody body: EmailRegister): DataResponse<TokenModel> {
        if (body.token.isNullOrEmpty() || body.code.isNullOrEmpty())
            throw BadParams()

        val decodeTokenData = authTokenService.parsePhoneToken(body.token) ?: throw BadParams()

        if (decodeTokenData.second != body.code) throw WrongPassword()

        return DataResponse.ok(
            TokenModel((body.token))
        )
    }

    @PostMapping("/register/step/3")
    fun registerStep3(@RequestBody body: UserEntity,
                      @RequestHeader("token") token: String): DataResponse<TokenModel> {
        val email = authTokenService.parsePhoneToken(token)?.first ?: throw BadParams()

        body.let {
            when {
                it.phoneNumber.isNullOrEmpty() -> throw BadParams()
                it.firstName.isEmpty() -> throw BadParams()
                it.lastName.isEmpty() -> throw BadParams()
                it.middleName.isEmpty() -> throw BadParams()
                it.password.isEmpty() -> throw BadParams()
                else -> print("onRegister final")
            }
        }

        val user = userDao.save(body.copy(
            email = email,
            role = roleType,
            isEmailActive = true
        ))

        return DataResponse.ok(
            TokenModel(
                authTokenService.generateToken(user)
            )
        )
    }

}