package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.UserSignUpResponse
import com.zakaion.api.entity.UserEntity
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/executor"])
class ExecutorController(private val userController: UserController) {

    @PostMapping("/sign/up")
    fun signUp(@RequestBody userEntity: UserEntity): DataResponse<UserSignUpResponse> {
        userEntity.isExecutor = true
        userEntity.isPhoneActive = true

        if (userEntity.phoneNumber.isNullOrEmpty() || userEntity.email.isEmpty())
            throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "phone or email is empty"
            )

        return userController.signUP(userEntity)
    }

}