package com.zakaion.api.model

data class ClientModel(
        val id: String,
        val firstName: String,
        val lastName: String,
        val middleName: String,
        val phoneNumber: String? = null,
        val email: String
)