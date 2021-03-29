package com.zakaion.api.model

data class NotificationTemplateSettingsModel(
        val smsAuth: String?,
        val createOrder: String?,
        val createOrderViaApp: String?,
        val youExecutorOrder: String?,
        val clientHasExecutorOrder: String?,
        val clientOrderInWork: String?,
        val addExecutorFeedback: String?,
        val addClientFeedback: String?
)