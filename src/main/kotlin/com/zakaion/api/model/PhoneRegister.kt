package com.zakaion.api.model

data class PhoneRegister(
        val phoneNumber: String,
        val smsCode: String? = null,
        val token: String? = null
)