package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.*
import com.zakaion.api.entity.user.*
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.*
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.EmailService
import com.zakaion.api.service.SmsService
import com.zakaion.api.service.StorageService
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.bind.annotation.*
import java.util.*
import kotlin.random.Random

@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping(value = ["user"])
class UserController(private val userDao: UserDao,
                     private val authTokenService: AuthTokenService,
                     private val storageService: StorageService,
                     private val userDeviceDao: UserDeviceDao,
                     private val orderDao: OrderDao,
                     private val feedbackDao: FeedbackDao,
                     private val smsService: SmsService,
                     private val cityDao: CityDao,
                     private val userFactory: UserFactory,
                     private val emailService: EmailService) : BaseController() {

    @PostMapping("/login")
    fun login(@RequestBody loginModel: LoginModel): DataResponse<TokenModel> {
        val user = userDao.findAll().find { it.email == loginModel.email && it.password == loginModel.password }?:
                throw WrongPassword()

        return DataResponse.ok(
                TokenModel(
                        authTokenService.generateToken(user)
                )
        )
    }

    fun get(): DataResponse<UserEntity> {
        val user = SecurityContextHolder
                .getContext()
                .authentication
                .principal as UserEntity

        return DataResponse.ok(
                user
        )
    }

    @GetMapping("/{userID}")
    fun user(@PathVariable userID: Long): DataResponse<UserImp> {

        val user = userDao.findById(userID).orElseGet {
            throw NotFound()
        }

        val fullUser = userFactory.create(user)

        return DataResponse.ok(
                fullUser!!
        )
    }

    @GetMapping("/")
    fun getReal(): DataResponse<UserImp> {
        val user = SecurityContextHolder
                .getContext()
                .authentication
                .principal as UserEntity

        val fullUser = userFactory.create(user)

        return DataResponse.ok(
                fullUser!!
        )
    }

    @PutMapping("/{id}/update")
    fun update(@RequestBody update: UserUpdateModel,
               @PathVariable("id") id: Long) : DataResponse<UserEntity> {
        val myUser = SecurityContextHolder
                .getContext()
                .authentication
                .principal as UserEntity

        if (myUser.role in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR) || myUser.id == id) {

            val user = userDao.findById(id).orElseGet { throw NotFound() }

            if (update.firstName != null)
                user.firstName = update.firstName

            if (update.lastName != null)
                user.lastName = update.lastName

            if (update.middleName != null)
                user.middleName = update.middleName

            if (update.phoneNumber != null) {
                if (userDao.findAll().any { it.id != user.id && it.phoneNumber == update.phoneNumber })
                    throw BadParams()

                user.phoneNumber = update.phoneNumber
                user.isPhoneActive = false
            }

            if (update.email != null) {
                if (userDao.findAll().any { it.id != user.id && it.email == update.email })
                    throw BadParams()

                user.email = update.email!!
                user.isEmailActive = false
            }

            if (update.avatar != null) {
                if (user.avatar != null)
                    storageService.delete(user.avatar!!)

                if (update.avatar.isNotEmpty()) {
                    user.avatar = storageService.store(Base64.getDecoder().decode(update.avatar), "jpg")
                }
                else {
                    user.avatar = null
                }
            }

            if (update.cityID != null) {
                val city = cityDao.findById(update.cityID).orElseGet {
                    throw NotFound()
                }
                user.city = city
            }

            return DataResponse.ok(
                    userDao.save(user)
            )
        }

        throw NoPermittedMethod()
    }

    @PutMapping("/update")
    fun update(@RequestBody update: UserUpdateModel) : DataResponse<UserEntity> {
        val myUser = SecurityContextHolder
                .getContext()
                .authentication
                .principal as UserEntity

        return update(update, myUser.id)
    }

    @PutMapping("/active/phone")
    fun activePhone(@RequestBody phoneRegister: PhoneRegister) : DataResponse<TokenModel?> {
        val myUser = get().data

        if (myUser.phoneNumber.isNullOrEmpty()) throw BadParams()

        if (phoneRegister.smsCode == null || phoneRegister.token == null) {
            val code = "1234"
            val token = authTokenService.generatePhoneToken(myUser.phoneNumber!!, code)

            smsService.sendCode(myUser.phoneNumber!!, code)

            return DataResponse.ok(
                    TokenModel((token))

            )
        }

        val decodeTokenData = authTokenService.parsePhoneToken(phoneRegister.token) ?: throw BadParams()

        if (decodeTokenData.first == myUser.phoneNumber && decodeTokenData.second == phoneRegister.smsCode) {
            myUser.isPhoneActive = true
            userDao.save(myUser)
            return DataResponse.ok(null)
        }

        throw WrongPassword()
    }

    @PutMapping("/active/email")
    fun activeEmail(@RequestBody phoneRegister: EmailRegister) : DataResponse<TokenModel?> {
        val myUser = get().data

        if (myUser.email.isNullOrEmpty()) throw BadParams()

        if (phoneRegister.code == null || phoneRegister.token == null) {
            val code = authTokenService.generateAuthCode()

            emailService.sendVerificationCode(myUser.email!!, code)

            val token = authTokenService.generatePhoneToken(myUser.email!!, code)

            return DataResponse.ok(
                    TokenModel((token))
            )
        }

        val decodeTokenData = authTokenService.parsePhoneToken(phoneRegister.token) ?: throw BadParams()

        if (decodeTokenData.first == myUser.email && decodeTokenData.second == phoneRegister.code) {
            myUser.isEmailActive = true
            userDao.save(myUser)
            return DataResponse.ok(null)
        }

        throw WrongPassword()
    }

    @PostMapping("/reset/password")
    fun resetPassword(@RequestBody emailRegister: EmailRegister) : DataResponse<TokenModel?> {

        if (emailRegister.code == null || emailRegister.token == null) {
            val user = {userDao.findAll().find { it.email == emailRegister.email } ?: throw NotFound()}.invoke()

            val code = "1234"
            val token = authTokenService.generatePhoneToken(user.email!!, code)

            //TODO(Send mail with code)

            return DataResponse.ok(
                    TokenModel((token))
            )
        }

        val decodeTokenData = authTokenService.parsePhoneToken(emailRegister.token) ?: throw BadParams()

        val user = {userDao.findAll().find { it.email == decodeTokenData.first } ?: throw NotFound()}.invoke()

        if (decodeTokenData.first == user.email && decodeTokenData.second == emailRegister.code) {
            user.isEmailActive = true
            userDao.save(user)

            //TODO(Send mail with user password)

            return DataResponse.ok(null)
        }

        throw WrongPassword()

    }

    /*@PutMapping("/change/password")
    fun changePassword(@RequestBody changePasswordModel: ChangePasswordModel) : DataResponse<Nothing?> {
        val myUser = get().data

        if (myUser.password != changePasswordModel.oldPassword) throw WrongPassword()

        myUser.password = changePasswordModel.newPassword

        userDao.save(myUser)

        return DataResponse.ok(null)
    }*/

    @PutMapping("/{id}/change/password")
    fun changeUserPassword(@PathVariable("id") id: Long, @RequestBody changePasswordModel: ChangePasswordModel) : DataResponse<Nothing?> {
        val myUser = get().data

        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (myUser.role == RoleType.SUPER_ADMIN || myUser.id == user.id ||
                (myUser.role == RoleType.ADMIN && user.role != RoleType.SUPER_ADMIN) ||
                (myUser.role == RoleType.EDITOR && user.role != RoleType.SUPER_ADMIN && user.role != RoleType.ADMIN)) {

            user.password = changePasswordModel.newPassword

            userDao.save(user)

            if (user.email != null) {
                emailService.sendMsg(
                    user.email!!,
                    "Ваш пароль на сервисе Zakazy.online был изменен. Если Вы этого не делали СРОЧНО свяжитесь со службой поддержки."
                )
            }

            return DataResponse.ok(null)
        }
        else
            throw NoPermittedMethod()
    }

    @PutMapping("/add/device")
    fun addDevice(@RequestBody deviceRegister: DeviceRegister) : DataResponse<Nothing?> {
        if (deviceRegister.fcmToken.isEmpty() || deviceRegister.name.isEmpty()) throw BadParams()

        val myUser = get().data

        userDeviceDao.save(
                UserDeviceEntity(
                        name = deviceRegister.name,
                        user = myUser,
                        fmcToken = deviceRegister.fcmToken
                )
        )

        return DataResponse.ok(null)
    }

    @CanSuperAdmin_Admin_Editor
    @PutMapping("/{id}/block")
    fun blockUser(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val myUser = get().data

        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (myUser.role == RoleType.SUPER_ADMIN ||
                (myUser.role == RoleType.ADMIN && user.role != RoleType.SUPER_ADMIN) ||
                (myUser.role == RoleType.EDITOR && user.role != RoleType.SUPER_ADMIN && user.role != RoleType.ADMIN)) {

            user.isBlocked = !user.isBlocked

            userDao.save(user)

            return DataResponse.ok(null)
        }
        else
            throw NoPermittedMethod()
    }

}