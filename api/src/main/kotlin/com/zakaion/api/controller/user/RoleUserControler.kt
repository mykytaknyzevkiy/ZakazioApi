package com.zakaion.api.controller.user

import com.zakaion.api.ExFuncs.filterWork
import com.zakaion.api.ExFuncs.mapWork
import com.zakaion.api.ExFuncs.toPage
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp
import com.zakaion.api.entity.user.UserStatus
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.factor.UserFullImp
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.EmailRegister
import com.zakaion.api.model.ExecutorInfo
import com.zakaion.api.model.TokenModel
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.EmailService
import com.zakaion.api.service.NotificationService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
abstract class RoleUserController(private val userDao: UserDao,
                                  private val authTokenService: AuthTokenService,
                                  private val emailService: EmailService,
                                  private val userFactory: UserFactory) {

    abstract val roleType: RoleType

    @PostMapping("/register/step/1")
    fun registerStep1(@RequestBody body: EmailRegister): DataResponse<TokenModel> {
        print("on registerStep1")
        if (body.email.isNullOrEmpty())
            throw BadParams()

        if (userDao.findAll().any { it.email == body.email && it.password.isNotEmpty()}) {
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

    @GetMapping("/list")
    suspend fun list(pageable: Pageable,
             @RequestParam("search", required = false, defaultValue = "") search: String,
             @RequestParam("region_id", required = false, defaultValue = "-1") regionID: Long = -1L,
             @RequestParam("city_id", required = false, defaultValue = "-1") cityID: Long = -1L,
             @RequestParam("status", required = false) status: UserStatus? = null,
             @RequestParam("masterID", required = false, defaultValue = "-1") masterID: Long = -1L): DataResponse<Page<UserFullImp>> {
        val searchOperator: (UserEntity) -> Boolean = {
            it.id.toString().contains(search)
                    || it.firstName.contains(search)
                    || it.lastName.contains(search)
                    || it.middleName.contains(search)
                    || (it.email?.contains(search)?:false)
                    || (it.phoneNumber?.contains(search)?:false)
        }
        val regionOperator: (UserEntity) -> Boolean = {
            it.city?.region?.id == regionID || regionID == -1L
        }
        val cityOperator: (UserEntity) -> Boolean = {
            it.city?.id == cityID || cityID == -1L
        }
        val masterOperator: (UserEntity) -> Boolean = {
            it.masterID == masterID || masterID == -1L
        }

        val myUser = userFactory.myUser

        val list: Page<UserFullImp> = (
                if (myUser.role == RoleType.PARTNER)
                    userDao.findByRole(roleType.ordinal, userFactory.myUser.id)
                else
                    userDao.findByRole(roleType.ordinal)
                )
            .asSequence()
            .filter {
                searchOperator(it)
                        && regionOperator(it)
                        && cityOperator(it)
                        && masterOperator(it)
            }
            .toList()
            //.toPage(pageable)
            .map { userFactory.createWork(it, myUser)!! }
            .filter {
                it.status == status || status == null
            }
            .toPage(pageable)

        return DataResponse.ok(
            list
        )
    }

}