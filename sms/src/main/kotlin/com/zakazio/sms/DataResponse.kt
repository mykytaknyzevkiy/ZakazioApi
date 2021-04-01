package com.zakazio.sms

data class DataResponse<T>(
        val success: Boolean,
        val error: String?,
        val data: T
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