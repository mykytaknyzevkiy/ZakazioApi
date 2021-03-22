package com.zakaion.api.model

import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.category.ChildCategoryEntity

data class GlobalCategory(
    val parent: CategoryEntity,
    val childList: List<ChildCategoryEntity>
)
