package com.zakaion.api.model

import com.zakaion.api.entity.OrderEntity

data class UserOrder(
        val count: OrderCount,
        var enable: Boolean = count.open < count.max
) {
    companion object {
        fun create(orders: List<OrderEntity>) : UserOrder {
            return UserOrder(
                    count = OrderCount.create(orders)
            )
        }
    }
}