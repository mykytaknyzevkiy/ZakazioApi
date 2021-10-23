package com.zakaion.api.model

data class OutSumRequestBody(
    val bankCardID: Long? = null,
    val amount: Float,
    val orderID: Long? = null
)