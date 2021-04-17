package com.zakaion.api.model

data class NotificationPermittedModel(
        val createOrder: Boolean?,
        val onExecutorInOrder: Boolean?,
        val onOrderStatus: Boolean?
)