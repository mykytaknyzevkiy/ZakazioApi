package com.zakaion.api.controller.app

import com.zakaion.api.unit.Config
import com.zakaion.api.unit.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.AppEntity
import com.zakaion.api.model.ClientModel
import com.zakaion.api.repository.UserRepository
import org.springframework.web.bind.annotation.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.appUrl + "/client"])
class AppClientsController (
        private val partnerAppController: PartnerAppController,
        private val orderDao: OrderDao,
        private val userRepository: UserRepository
) {

    @GetMapping("/list")
    fun list(@RequestHeader(name = Config.appKeyParameterName) apiKey: String,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10)
            : DataResponse<PageResponse<ClientModel>> {
        val app = partnerAppController.key(apiKey).data as AppEntity

        val orderUserIds = orderDao.findAll().filter { it.app == app }.map { it.client.id }
        val users = userRepository.users().filter { orderUserIds.contains(it.id) }.map {
            ClientModel(
                    id = it.id,
                    firstName = it.firstName,
                    lastName = it.lastName,
                    middleName = it.midleName,
                    phoneNumber = it.phoneNumber,
                    email = it.email
            )
        }

        return DataResponse(
                data = UnitN.makePaginationResponse(users, pageNo = page, pageSize = size)
        )
    }

}