package com.zakaion.api.controller.history

import com.zakaion.api.dao.history.OrderHistoryDao
import com.zakaion.api.entity.history.OrderHistoryEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["history/order"])
class OrderHistoryController(private val orderHistoryDao: OrderHistoryDao,
                             private val userFactory: UserFactory)  {

    fun add(order: OrderEntity, user: UserEntity, data: String) {
        orderHistoryDao.save(OrderHistoryEntity(
            user = user,
            data = data,
            order = order
        ))
    }

    @GetMapping("/user/{user_id}")
    fun user(@PathVariable("user_id") userID: Long,
             pageable: Pageable) : DataResponse<Page<OrderHistoryEntity>> {

        return DataResponse.ok(
            orderHistoryDao.findAll(pageable, userID)
        )
    }

    @GetMapping("/order/{order_id}")
    fun order(@PathVariable("order_id") orderID: Long,
             pageable: Pageable) : DataResponse<Page<OrderHistoryEntity>> {

        return DataResponse.ok(
            orderHistoryDao.findAllOfOrder(pageable, orderID)
        )
    }
}