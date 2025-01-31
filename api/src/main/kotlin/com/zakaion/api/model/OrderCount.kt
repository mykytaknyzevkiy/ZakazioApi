package com.zakaion.api.model

import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.service.Preference

data class OrderCount(
    val open: Int = 0,
    val close: Int = 0,
    var declined: Int = 0,
    val max: Int = Preference.executorMaxOrder
) {

    companion object {
        fun create(orders: List<OrderEntity>) : OrderCount {
            return OrderCount(
                    open = orders.filter { it.status != OrderStatus.CANCEL && it.status != OrderStatus.DONE }.size,
                    close = orders.filter {it.status == OrderStatus.DONE }.size,
                    declined = 0,
                    max = Preference.executorMaxOrder
            )
        }
    }

}