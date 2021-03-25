package com.zakaion.api.model

data class FullTransactionResponse(
    val systemAmount: Float,
    val partnerAmount: Float,
    val outFromSystemAmount: Float,
    val list: List<TransactionImpResponse>
)
