package com.zakaion.api.model

data class EmailRegister(
        val email: String? = null,
        val code: String? = null,
        val token: String? = null
)