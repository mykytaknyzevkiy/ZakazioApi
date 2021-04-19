package com.zakaion.api.controller.dashboard.model

import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.entity.user.UserEntity

data class CategoryAnalytic(
    val info: CategoryEntity,
    val childList: ArrayList<ChildCategoryAnalytic> = arrayListOf(),
    override var executors: LinkedHashSet<UserEntity> = linkedSetOf(),
    override var partners: LinkedHashSet<UserEntity> = linkedSetOf(),
    override var orderCount: Int = 0,
    override var executorCount: Int = 0,
    override var partnerCount: Int = 0,
    override var orderTotalPrice: Float = 0f,
    override var systemTotalPrice: Float = 0f,
): SampleAnalytic(executors, partners, orderCount, executorCount, partnerCount, orderTotalPrice, systemTotalPrice) {

    fun run() {
        executors = run {
            val data = LinkedHashSet<UserEntity>()
            childList.forEach {
                data.addAll(it.executors)
            }
            data
        }
        partners = run {
            val data = LinkedHashSet<UserEntity>()
            childList.forEach {
                data.addAll(it.partners)
            }
            data
        }
        orderCount = run {
            var count = 0
            childList.forEach {
                count += it.orderCount
            }
            count
        }
        executorCount = executors.size
        partnerCount = partners.size
        orderTotalPrice = run {
            var count = 0f
            childList.forEach {
                count += it.orderTotalPrice
            }
            count
        }
        systemTotalPrice = run {
            var count = 0f
            childList.forEach {
                count += it.systemTotalPrice
            }
            count
        }
    }

}

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
