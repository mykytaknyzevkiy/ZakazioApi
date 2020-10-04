package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.controller.reponse.UserSignUpResponse
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.model.ExecutorModel
import com.zakaion.api.repository.UserRepository
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/executor"])
class ExecutorController(private val userController: UserController,
                         private val userRepository: UserRepository,
                         private val orderDao: OrderDao) {

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

    @GetMapping("/list")
    fun list(@RequestHeader(name = Config.tokenParameterName) token: String,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10
    ): DataResponse<PageResponse<ExecutorModel>> {
        val myUser = userController.user(token).data as UserEntity

        if (myUser.isExecutor)
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permitted"
            )

        val orders = orderDao.findAll().toList()

        val executors = userRepository.users()
                .filter { it.isExecutor || it.isAgent }
                .filter { (myUser.isAgent && it.agentRefID == myUser.id) || !myUser.isAgent }
                .map {
                    ExecutorModel(
                            id = it.id,
                            email = it.email,
                            phoneNumber = it.phoneNumber ?: "no",
                            firstName = it.firstName,
                            lastName = it.lastName,
                            midleName = it.midleName,
                            isAgent = it.isAgent,
                            orders = orders.filter {order -> order.executor?.id == it.id || order.executorAgent?.id == it.id }
                    )
                }

        return DataResponse(
                data = UnitN.makePaginationResponse(executors, page, size)
        )
    }

}