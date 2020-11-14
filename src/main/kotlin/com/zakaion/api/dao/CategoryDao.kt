package com.zakaion.api.dao

import com.zakaion.api.entity.order.CategoryEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface CategoryDao : PagingAndSortingRepository<CategoryEntity, Long>