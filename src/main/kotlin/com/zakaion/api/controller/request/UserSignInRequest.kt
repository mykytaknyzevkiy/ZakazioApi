package com.zakaion.api.controller.request

data class UserSignInRequest(
        val email: String,
        val password: String
)