package com.zakaion.api.model

import com.fasterxml.jackson.annotation.JsonFormat
import com.zakaion.api.entity.order.AppEntity
import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.entity.region.CityEntity
import java.util.*

data class OrderNModel(
    val id: Long,

    val status: OrderStatus,

    val title: String,
    val content: String,
    val price: Float,
    val dateLine: String,

    val city: CityEntity,

    val client: ClientInfo,
    val executor: ExecutorInfo?,
    val partner: PartnerInfo?,
    val app: AppEntity?,

    //@JsonFormat(pattern = "yyyy-MM-dd")
    val creationDate: Date,

    var editEnable: Boolean = false,
    var beExecutorEnable: Boolean = false,
    var setExecutorEnable: Boolean = false,
    var cancelExecutorEnable: Boolean = false,
    var inWorkEnable: Boolean = false,
    var doneEnable: Boolean = false,
    var cancelEnable: Boolean = false,

    var commentEnable: Boolean = false,

    val files: List<String>,

    val toShareSum: Float,

    val category: CategoryEntity,

    var defuseMeExecutorEnable: Boolean = false,

    val childCategory: ChildCategoryEntity
)