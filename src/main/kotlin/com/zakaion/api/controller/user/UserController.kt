package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.WrongPassword
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.LoginModel
import com.zakaion.api.model.TokenModel
import com.zakaion.api.service.AuthTokenService
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["user"])
class UserController(private val userDao: UserDao,
                     private val authTokenService: AuthTokenService) : BaseController() {

    @PostMapping("/login")
    suspend fun login(@RequestBody loginModel: LoginModel): DataResponse<TokenModel> {
        val user = userDao.findAll().find { it.email == loginModel.email && it.password == loginModel.password }?:
                throw WrongPassword()

        return DataResponse.ok(
                TokenModel(
                        authTokenService.generateToken(user)
                )
        )
    }

}