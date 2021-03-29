package com.zakaion.api.model

data class PrimarySettingsModel(
        val executorMaxOrder: Int?,
        val feedBackUrl: String?,
        val orderSumOutPercent: Int?,
        val orderPartnerPercent: Int?,
        val executorPartnerPercent: Int?
)