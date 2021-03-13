package com.zakaion.api.model

import com.zakaion.api.entity.order.AppEntity

data class NikitaModel<K, V>(
        val key: K,
        val value: V
)

data class DashboardModel(
        val oder: OrderAnalytic,
        val user: List<NikitaModel<String, Int>>,
        val transaction: TransactionAnalytic
)

data class OrderAnalytic(
        val total: Int,
        val statuses: List<NikitaModel<String, Int>>,
        val partners: List<NikitaModel<PartnerInfo, Int>>,
        val executors: List<NikitaModel<ExecutorInfo, Int>>,
        val apps: List<NikitaModel<AppEntity, Int>>,
        val dates: List<NikitaModel<String, Int>>
)

data class TransactionAnalytic(
        val systemTotalSum: Double,
        val totalInSum: Double,
        val totalOutCardSum: Double,
        val totalPartnerSum: Double,
        val totalOrderSum: Double,
        val totalInWaitOrderSum: Double,
        val totalLostOrderSum: Double,
        val totalSystemReceiveSum: Double,
        val dates: List<NikitaModel<String, Float>>
)