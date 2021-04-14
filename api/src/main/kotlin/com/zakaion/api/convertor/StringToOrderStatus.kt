package com.zakaion.api.convertor

import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.user.UserStatus
import org.springframework.core.convert.converter.Converter

class StringToOrderStatus : Converter<String, OrderStatus> {

    override fun convert(source: String): OrderStatus =
        OrderStatus.valueOf(source.toUpperCase())
}