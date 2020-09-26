package com.zakaion.api.controller.request

data class AppRequestBody(
        val title: String,
        val secret: String
)

data class AppRequestUpdateBody(
        val title: String,
        val notifyCurl: String
)