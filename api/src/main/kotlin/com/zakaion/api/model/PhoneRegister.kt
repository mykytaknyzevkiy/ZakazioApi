package com.zakaion.api.model

data class PhoneRegister(
        val phoneNumber: String? = null,
        val smsCode: String? = null,
        val token: String? = null
)