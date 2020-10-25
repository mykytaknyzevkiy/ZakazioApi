package com.zakaion.api.model

import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.UserEntity

data class ExecutorModel(
        val id: String,
        val email: String,
        var phoneNumber: String,
        val firstName: String,
        val lastName: String,
        val middleName: String?,
        val partnerID: String?,
        val isAgent: Boolean,
        val orders: List<OrderEntity>
)

fun convertToExecutor(userEntity: UserEntity) = ExecutorModel(
        id = userEntity.id,
        email = userEntity.email,
        phoneNumber = userEntity.phoneNumber?:"NO",
        firstName = userEntity.firstName,
        lastName = userEntity.lastName,
        middleName = userEntity.midleName,
        partnerID = userEntity.partnerID,
        isAgent = false,
        orders = emptyList()
)