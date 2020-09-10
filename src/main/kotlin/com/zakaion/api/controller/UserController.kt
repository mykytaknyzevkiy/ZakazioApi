package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.UserSignUpResponse
import com.zakaion.api.controller.request.UserChangePasswordRequest
import com.zakaion.api.controller.request.UserSignInRequest
import com.zakaion.api.dao.UserDao
import com.zakaion.api.dao.UserTokenDao
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl])
class UserController(private val userRepository: UserRepository) {

    @PostMapping("/sign/up")
    fun signUP(@RequestBody userEntity: UserEntity): DataResponse<UserSignUpResponse> {
        if (userRepository.users().find { it.email == userEntity.email } != null)
            throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "user exits"
            )

        val userID = userRepository.save(userEntity)

        val token = userRepository.createToken(userID)

        return DataResponse(
                success = true,
                error = null,
                data = UserSignUpResponse(
                        token = token.toke,
                        tokenExp = token.expiredDataStr()
                )
        )
    }

    @PostMapping("/sign/in")
    fun signIN(@RequestBody userSignInRequest: UserSignInRequest): DataResponse<UserSignUpResponse> {
        val user = userRepository.user(userSignInRequest.email, userSignInRequest.password)

        if (user.isEmpty)
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "user not found"
            )

        val token = userRepository.createToken(user.get().id)

        return DataResponse(
                success = true,
                error = null,
                data = UserSignUpResponse(
                        token = token.toke,
                        tokenExp = token.expiredDataStr()
                )
        )
    }

    @GetMapping("/user")
    fun user(@RequestHeader(name = Config.tokenParameterName) token: String): DataResponse<UserEntity> {
        userRepository.validateUserToken(token)

        val user = userRepository.userByToken(token)

        return DataResponse(
                success = true,
                error = null,
                data = user.apply {
                    this.password = "****"
                }
        )
    }

    @GetMapping("/user/{id}")
    fun user(@RequestHeader(name = Config.tokenParameterName) token: String,
             @PathVariable("id") userID: String): DataResponse<UserEntity> {
        userRepository.validateUserToken(token)

        val user = userRepository.user(userID).orElseGet {
            throw ResponseStatusException(
                    HttpStatus.NOT_FOUND, "user not found"
            )
        }

        return DataResponse(
                success = true,
                error = null,
                data = user.apply {
                    this.password = "****"
                }
        )
    }

    @PutMapping("/user/update/{id}")
    fun update(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable("id") userID: String,
               @RequestBody userEntity: UserEntity): DataResponse<UserEntity> {

        val myUser = user(token).data as UserEntity
        var updateUser = user(token, userID).data!!

        if (userID != myUser.id
                && !myUser.isAdmin
                && !myUser.isSuperAdmin) {
            throw ResponseStatusException(
                    HttpStatus.NOT_ACCEPTABLE, "No permission"
            )
        }

        updateUser.apply {
            this.firstName = userEntity.firstName
            this.lastName = userEntity.lastName
            this.midleName = userEntity.midleName
            this.phoneNumber = userEntity.phoneNumber
            this.isUser = userEntity.isUser
            if (myUser.isSuperAdmin) {
                this.isAdmin = userEntity.isAdmin
                this.isSuperAdmin = userEntity.isSuperAdmin
            }
            if (myUser.isAdmin || myUser.isSuperAdmin) {
                this.isEditor = userEntity.isEditor
            }
            this.isExecutor = userEntity.isExecutor
            this.isPartner = userEntity.isPartner
            this.isAgent = userEntity.isAgent
        }

        updateUser = userRepository.update(updateUser)

        return DataResponse(
                success = true,
                error = null,
                data = updateUser
        )
    }

    @PutMapping("/user/update/{id}/password")
    fun changePassword(@RequestHeader(name = Config.tokenParameterName) token: String,
                       @PathVariable("id") userID: String,
                       @RequestBody userChangePasswordRequest: UserChangePasswordRequest): DataResponse<UserEntity> {

        val myUser = user(token).data!!
        var updateUser = user(token, userID).data!!

        if (userID != myUser.id
                && !myUser.isAdmin
                && !myUser.isSuperAdmin) {
            throw ResponseStatusException(
                    HttpStatus.NOT_ACCEPTABLE, "No permission"
            )
        }

        updateUser.password = userChangePasswordRequest.newPassword

        updateUser = userRepository.update(updateUser)

        return DataResponse(
                success = true,
                error = null,
                data = updateUser
        )
    }

    @GetMapping("/user/list")
    fun list(@RequestHeader(name = Config.tokenParameterName) token: String): DataResponse<List<UserEntity>> {
        userRepository.validateUserToken(token)

        return DataResponse(
                success = true,
                data = userRepository.users().map {
                    it.apply {
                        it.password = "****"
                    }
                }
        )
    }

}