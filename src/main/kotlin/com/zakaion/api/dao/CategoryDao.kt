package com.zakaion.api.dao

import com.zakaion.api.entity.order.CategoryEntity
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param
import org.springframework.data.domain.Pageable
import org.springframework.data.domain.Page
import org.springframework.data.jpa.repository.Query


interface CategoryDao : PagingAndSortingRepository<CategoryEntity, Long> {

    @Query(value = "select * from category where isActive = 1", nativeQuery = true)
    fun findAllActive(pageable: Pageable) : Page<CategoryEntity>

}