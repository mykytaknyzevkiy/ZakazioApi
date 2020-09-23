package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.UserSignUpResponse
import com.zakaion.api.controller.request.UserSignInRequest
import com.zakaion.api.entity.UserEntity
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/partner/"])
class PartnerController (private val userController: UserController) {

    @GetMapping("/user")
    fun user(@RequestHeader(name = Config.tokenParameterName) token: String): DataResponse<UserEntity> {
        val myUser = userController.user(token).data as UserEntity
        if (myUser.isPartner) {
            return DataResponse(
                    data = myUser
            )
        }
        else {
            throw ResponseStatusException(
                    HttpStatus.NOT_FOUND, "user is not partner"
            )
        }
    }

    @PostMapping("/user/signup")
    fun signUp(@RequestBody userEntity: UserEntity): DataResponse<UserSignUpResponse> {
        userEntity.isPartner = true

        return userController.signUP(userEntity)
    }

}