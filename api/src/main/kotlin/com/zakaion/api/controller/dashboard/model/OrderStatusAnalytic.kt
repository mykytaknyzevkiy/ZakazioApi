package com.zakaion.api.controller.dashboard.model

import com.zakaion.api.entity.order.OrderStatus

data class OrderStatusAnalytic(
    val info: OrderStatus,
    var orderCount: Int = 0
)
