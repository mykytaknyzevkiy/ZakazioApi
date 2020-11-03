package com.zakaion.api.model

data class DataResponse<T>(
        val success: Boolean,
        val error: String?,
        val data: T
)