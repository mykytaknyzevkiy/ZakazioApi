package com.zakaion.api.controller.reponse

data class UserSignUpResponse(
        val token: String,
        val tokenExp: String
)