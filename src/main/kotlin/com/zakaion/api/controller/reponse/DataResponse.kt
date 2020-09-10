package com.zakaion.api.controller.reponse

import com.zakaion.api.Config

data class DataResponse<T>(
        val version: String = Config.version,
        val success: Boolean,
        val error: String? = null,
        val data: T?
)