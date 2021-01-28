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
        val inComingSum: Float,
        val dates: List<NikitaModel<String, Float>>
)