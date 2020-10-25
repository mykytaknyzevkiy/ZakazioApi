package com.zakaion.api.model

import com.zakaion.api.entity.AppEntity
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.UserEntity
import java.util.*

data class OrderResponse(
        val id: Int,
        val content: String,
        val price: Float,
        val category: CategoryEntity,
        val files: List<String>,
        val app: AppEntity,
        var client: ClientModel? = null,
        val executor: ExecutorModel? = null,
        val status: String,
        val createdAt: Date
)

fun convert(orderEntity: OrderEntity) = OrderResponse(
        id = orderEntity.id,
        content = orderEntity.content,
        price = orderEntity.totalPrice,
        category = orderEntity.category,
        files = emptyList(),
        app = orderEntity.app,
        client = convert(orderEntity.client),
        executor = if (orderEntity.executor != null) convertToExecutor(orderEntity.executor!!) else null,
        status = orderEntity.status,
        createdAt = orderEntity.creationDateTime
)