package com.zakaion.api.controller.history

import com.zakaion.api.Config
import com.zakaion.api.dao.OrderHistoryDao
import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.OrderHistoryEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/history"])
class OrderHistoryController(private val orderHistoryDao: OrderHistoryDao) {

    fun list(orderID: String): List<OrderHistoryEntity>
            = orderHistoryDao.findAll().filter { it.order.id == orderID }.toList()

    fun add(orderHistoryEntity: OrderHistoryEntity) = orderHistoryDao.save(orderHistoryEntity)

}