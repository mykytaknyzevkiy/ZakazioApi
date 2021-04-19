package com.zakaion.api.controller.dashboard.model

import com.fasterxml.jackson.annotation.JsonInclude
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity

abstract class SampleAnalytic(
    @JsonInclude
    open val executors: LinkedHashSet<UserEntity> = LinkedHashSet(),
    @JsonInclude
    open val partners: LinkedHashSet<UserEntity> = LinkedHashSet(),
    open var orderCount: Int,
    open var executorCount: Int,
    open var partnerCount: Int,
    open var orderTotalPrice: Float,
    open var systemTotalPrice: Float
)

fun SampleAnalytic.calculate(order: OrderEntity, transactionsIn: Iterable<TransactionInEntity>): SampleAnalytic {
    return this.apply {
        orderCount += 1

        if (order.executor != null)
            executors.add(order.executor!!)

        if (order.partner != null)
            partners.add(order.partner)

        orderTotalPrice += order.price

        transactionsIn
            .filter {
                it.order?.id == order.id
                        && it.user.role == RoleType.SUPER_ADMIN
            }
            .forEach {
                systemTotalPrice += it.amount
            }
    }
}