package com.zakaion.api.model

import com.zakaion.api.entity.OrderEntity

data class ExecutorModel(
        val id: String,
        val email: String,
        var phoneNumber: String,
        val firstName: String,
        val lastName: String,
        val midleName: String,
        val isAgent: Boolean,
        val orders: List<OrderEntity>
)