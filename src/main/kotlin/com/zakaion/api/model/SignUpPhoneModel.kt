package com.zakaion.api.model

data class SignUpPhoneModel(
        val phone: String,
        val code: String? = null
)