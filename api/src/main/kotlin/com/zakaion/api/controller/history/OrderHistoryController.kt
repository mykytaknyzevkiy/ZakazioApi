package com.zakaion.api.controller.history

import com.zakaion.api.dao.history.OrderHistoryDao
import com.zakaion.api.entity.history.OrderHistoryEntity
import com.zakaion.api.entity.history.OrderHistoryType
import com.zakaion.api.entity.history.OrderHistoryType.*
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

    fun add(order: OrderEntity, user: UserEntity, type: OrderHistoryType) {
        orderHistoryDao.save(OrderHistoryEntity(
            user = user,
            data = when (type) {
                CREATE -> "Создал заказ"
                EDIT -> "Отредактировал"
                BE_EXECUTOR -> "Стал исполнителем"
                SET_EXECUTOR -> "Назначил исполнителя"
                CANCEL_EXECUTOR -> "Отменил исполнителя"
                START_WORK -> "Начал работу"
                DONE_WORK -> "Завершил работу"
                CANCEL -> "Отменил заказ"
                SHARE_SUM -> "Перевел сумму"
            },
            order = order,
            type = type
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