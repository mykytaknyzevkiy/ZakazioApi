package com.zakaion.api.model

import com.zakaion.api.entity.UserEntity

data class ClientModel(
        val id: String,
        val firstName: String,
        val lastName: String,
        val middleName: String,
        val phoneNumber: String? = null,
        val email: String
)

fun convert(userEntity: UserEntity) = ClientModel(
        id = userEntity.id,
        firstName = userEntity.firstName,
        lastName = userEntity.lastName,
        middleName = userEntity.midleName,
        phoneNumber = userEntity.phoneNumber,
        email = userEntity.email
)