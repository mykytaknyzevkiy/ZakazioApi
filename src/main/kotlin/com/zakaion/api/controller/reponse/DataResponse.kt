package com.zakaion.api.controller.reponse

import com.zakaion.api.unit.Config

data class DataResponse<T>(
        val version: String = Config.version,
        val success: Boolean = true,
        val error: String? = null,
        var data: T?
)