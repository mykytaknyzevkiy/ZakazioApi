package com.zakaion.api.dao

import com.zakaion.api.entity.help.HelpMessageEntity
import com.zakaion.api.entity.order.OrderEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface HelpMessageDao : PagingAndSortingRepository<HelpMessageEntity, Long> {

    @Query(value = "select * from help_message where worker_id IS NULL", nativeQuery = true)
    fun findAllNoMaster(pageable: Pageable): Page<HelpMessageEntity>

    @Query(value = "select * from help_message where worker_id = :masterID", nativeQuery = true)
    fun findAllMaster(pageable: Pageable, @Param("masterID") masterID: Long): Page<HelpMessageEntity>

}