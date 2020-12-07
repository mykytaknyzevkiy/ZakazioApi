package com.zakaion.api.model

data class UserUpdateModel(
        val firstName: String? = null,
        val lastName: String? = null,
        val middleName: String? = null,
        val email: String? = null,
        val phoneNumber: String? = null,
        val avatar: String? = null,
        val cityID: Long? = null
)