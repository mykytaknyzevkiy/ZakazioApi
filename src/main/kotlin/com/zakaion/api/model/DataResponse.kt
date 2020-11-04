package com.zakaion.api.model

import com.zakaion.api.appVersion

data class DataResponse<T>(
        val success: Boolean,
        val error: String?,
        val data: T,
        val version: String = appVersion
) {

    companion object {
        fun <T> ok(data: T): DataResponse<T> {
            return DataResponse(
                    success = true,
                    error = null,
                    data = data
            )
        }
    }

}