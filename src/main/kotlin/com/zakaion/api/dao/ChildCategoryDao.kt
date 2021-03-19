package com.zakaion.api.dao

import com.zakaion.api.entity.order.category.ChildCategoryEntity
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.domain.Pageable
import org.springframework.data.domain.Page
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param

interface ChildCategoryDao : PagingAndSortingRepository<ChildCategoryEntity, Long> {

    @Query("select * from category_child where parent_id = :PARENT_ID", nativeQuery = true)
    fun findAll(pageable: Pageable, @Param("PARENT_ID") parentID: Long): Page<ChildCategoryEntity>

    @Query("select * from category_child where parent_id = :PARENT_ID and name like %:QUERY%", nativeQuery = true)
    fun findAll(pageable: Pageable,
                @Param("PARENT_ID") parentID: Long,
                @Param("QUERY") query: String): Page<ChildCategoryEntity>

}