package com.zakaion.api.controller

import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.model.DashboardMolder
import com.zakaion.api.repository.CashRepository
import com.zakaion.api.unit.Config
import org.springframework.web.bind.annotation.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/dashboard"])
class DashboardController(
        private val userController: UserController,
        private val cashRepository: CashRepository
) {

    @GetMapping("")
    fun info(@RequestHeader(name = Config.tokenParameterName) token: String): DataResponse<DashboardMolder> {
        val user = userController.user(token).data as UserEntity
        val balance = cashRepository.userBalance(user)

        return DataResponse(
                data = DashboardMolder(
                        balance = balance
                )
        )
    }

}