package com.zakaion.api.dao

import com.zakaion.api.entity.order.AppEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface AppDao : PagingAndSortingRepository<AppEntity, Long> {

    @Query(value = "select * from app_n where masterID = :u_id", nativeQuery = true)
    fun find(@Param("u_id") userID: Long, pageable: Pageable) : Page<AppEntity>

}