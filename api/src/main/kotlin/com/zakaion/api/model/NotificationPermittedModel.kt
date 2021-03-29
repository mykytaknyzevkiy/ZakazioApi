package com.zakaion.api.model

data class NotificationPermittedModel(
        val createOrder: Boolean?,
        val youExecutorOrder: Boolean?,
        val clientHasExecutor: Boolean?,
        val clientOrderInWork: Boolean?
)