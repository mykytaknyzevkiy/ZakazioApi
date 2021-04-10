package com.zakaion.socket.module

data class ImportOrderProcessModel(
    val process: Int,
    val max: Int,
    val brokers: List<ImportOrderProcessBrokeReason>
)

data class ImportOrderProcessBrokeReason(
    val index: Int,
    val reason: String
)