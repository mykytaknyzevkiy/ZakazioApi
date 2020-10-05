package com.zakaion.api.model

enum class OrderHistoryOperation(val data: String) {
    CREATE("create"),
    EDIT("edit"),
    SET_EXECUTOR("set_executor"),
    CANCEL_EXECUTOR("set_executor"),
    CANCEL("cancel"),
    CLOSE("close")
}