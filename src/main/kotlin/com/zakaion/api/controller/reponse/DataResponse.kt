package com.zakaion.api.controller.reponse

data class DataResponse<T>(
        val success: Boolean,
        val error: String? = null,
        val data: T?
)