package com.zakaion.api.model

data class UserUpdateModel(
        var firstName: String? = null,
        var lastName: String? = null,
        var middleName: String? = null,
        var email: String? = null,
        var phoneNumber: String? = null
)