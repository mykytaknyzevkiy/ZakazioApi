package com.zakaion.api.controller.dashboard.model

import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.entity.user.UserEntity

data class CategoryAnalytic(
    val info: CategoryEntity,
    val childList: ArrayList<ChildCategoryAnalytic> = arrayListOf(),
    override val executors: LinkedHashSet<UserEntity> = run {
        val data = LinkedHashSet<UserEntity>()
        childList.forEach {
            data.addAll(it.executors)
        }
        data
    },
    override val partners: LinkedHashSet<UserEntity> = run {
        val data = LinkedHashSet<UserEntity>()
        childList.forEach {
            data.addAll(it.partners)
        }
        data
    },
    override var orderCount: Int = 0,
    override var executorCount: Int = executors.size,
    override var partnerCount: Int = partners.size,
    override var orderTotalPrice: Float = 0f,
    override var systemTotalPrice: Float = 0f,
): SampleAnalytic(executors, partners, orderCount, executorCount, partnerCount, orderTotalPrice, systemTotalPrice)

data class ChildCategoryAnalytic(
    val info: ChildCategoryEntity,
    override val executors: LinkedHashSet<UserEntity> = LinkedHashSet(),
    override val partners: LinkedHashSet<UserEntity> = LinkedHashSet(),
    override var orderCount: Int = 0,
    override var executorCount: Int = executors.size,
    override var partnerCount: Int = partners.size,
    override var orderTotalPrice: Float = 0f,
    override var systemTotalPrice: Float = 0f,
): SampleAnalytic(executors, partners, orderCount, executorCount, partnerCount, orderTotalPrice, systemTotalPrice)
