package com.zakaion.api.controller.app

import com.zakaion.api.Config
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.AppEntity
import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.OrderStatus
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.repository.CategoryRepository
import com.zakaion.api.repository.UserRepository
import org.springframework.http.*
import org.springframework.web.bind.annotation.*
import org.springframework.web.client.RestTemplate
import org.springframework.web.server.ResponseStatusException
import java.util.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.appUrl + "/order"])
class AppOrderController (
        private val partnerAppController: PartnerAppController,
        private val userRepository: UserRepository,
        private val categoryRepository: CategoryRepository,
        private val orderDao: OrderDao,
        private val restTemplate: RestTemplate
) {

    fun client(email: String,
               phoneNumber: String,
               firstName: String,
               lastName: String,
               middleName: String
    ): UserEntity {
        val userByEmail = userRepository.userByEmail(email).orElse(UserEntity(
                email = email,
                phoneNumber = phoneNumber,
                firstName = firstName,
                lastName = lastName,
                midleName = middleName,
                isUser = true,
                isPhoneActive = true
        ))

        if (userByEmail.id.isEmpty())
            userByEmail.id = userRepository.save(userByEmail)

        return userByEmail
    }

    fun notifyPartner(orderEntity: OrderEntity) {
        sendCurlNotify(orderEntity)
    }

    fun sendCurlNotify(orderEntity: OrderEntity) {
        val url = orderEntity.app.notifyCurl?:return

        // create headers
        val headers = HttpHeaders()
        headers.contentType = MediaType.APPLICATION_JSON
        headers.accept = Collections.singletonList(MediaType.APPLICATION_JSON)

        // create a map for post parameters

        // create a map for post parameters
        val map: MutableMap<String, Any> = HashMap()
        map["title"] = "New order"
        map["orderID"] = orderEntity.id

        // build the request
        val entity = HttpEntity(map, headers)

        // send POST request

        this.restTemplate.postForEntity(url, entity, String::class.java)
    }

    @PostMapping("/add")
    fun add(@RequestHeader(name = Config.appKeyParameterName) apiKey: String,
            @RequestBody orderEntity: OrderEntity): DataResponse<OrderEntity> {

        val app = partnerAppController.key(apiKey).data as AppEntity

        if (orderEntity.client.email.isEmpty()
                || orderEntity.client.phoneNumber.isNullOrEmpty()
                || orderEntity.client.firstName.isEmpty()
                || orderEntity.client.lastName.isEmpty())
            throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "Fill user data"
            )

        else if (orderEntity.category.id.isEmpty())
            throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "Select category"
            )

        orderEntity.client = client(
                orderEntity.client.email,
                orderEntity.client.phoneNumber!!,
                orderEntity.client.firstName,
                orderEntity.client.lastName,
                orderEntity.client.midleName
        )

        val category = categoryRepository.get(orderEntity.category.id)

        if (!category.active)
            throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "Category is deactivate"
            )

        orderEntity.executor = null
        orderEntity.executorAgent = null
        orderEntity.status = OrderStatus.PROCESS.data
        orderEntity.app = app
        orderEntity.category = category

        val data = orderDao.save(orderEntity)

        notifyPartner(data)

        return DataResponse(
                data = data
        )
    }

}