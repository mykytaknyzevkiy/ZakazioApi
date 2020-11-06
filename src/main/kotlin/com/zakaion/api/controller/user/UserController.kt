package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.LoginModel
import com.zakaion.api.model.TokenModel
import com.zakaion.api.model.UserUpdateModel
import com.zakaion.api.service.AuthTokenService
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["user"])
class UserController(private val userDao: UserDao,
                     private val authTokenService: AuthTokenService) : BaseController() {

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

    @GetMapping("/")
    fun get(): DataResponse<UserEntity> {
        val user = SecurityContextHolder
                .getContext()
                .authentication
                .principal as UserEntity

        return DataResponse.ok(
                user
        )
    }

    @PutMapping("/{id}/update")
    fun update(@RequestBody update: UserUpdateModel,
               @PathVariable("id") id: Long) : DataResponse<UserEntity> {
        val myUser = get().data

        if (myUser.role in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR) || myUser.id == id) {

            val user = userDao.findById(id).orElseGet { throw NotFound() }

            if (update.firstName != null)
                user.firstName = update.firstName!!

            if (update.lastName != null)
                user.lastName = update.lastName!!

            if (update.middleName != null)
                user.middleName = update.middleName!!

            if (update.phoneNumber != null) {
                if (userDao.findAll().any { it.id != user.id && it.phoneNumber == update.phoneNumber })
                    throw BadParams()

                user.phoneNumber = update.phoneNumber!!
                user.isPhoneActive = false
            }

            if (update.email != null) {
                if (userDao.findAll().any { it.id != user.id && it.email == update.email })
                    throw BadParams()

                user.email = update.email!!
                user.isEmailActive = false
            }

            return DataResponse.ok(
                    userDao.save(user)
            )

        }

        throw NoPermittedMethod()
    }

    @PutMapping("/update")
    fun update(@RequestBody update: UserUpdateModel) : DataResponse<UserEntity> {
        val myUser = get().data

        return update(update, myUser.id)
    }

}