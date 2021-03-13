package com.zakaion.api.dao.history

import com.zakaion.api.entity.history.OrderHistoryEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface OrderHistoryDao : PagingAndSortingRepository<OrderHistoryEntity, Long> {

    @Query(value = "select * from order_history where user_id = :u_id", nativeQuery = true)
    fun findAll(@Param("u_id") userID: Long): Iterable<OrderHistoryEntity>

    @Query(value = "select * from order_history where user_id = :u_id", nativeQuery = true)
    fun findAll(pageable: Pageable, @Param("u_id") userID: Long): Page<OrderHistoryEntity>

    @Query(value = "select * from order_history where order_id = :o_id", nativeQuery = true)
    fun findAllOfOrder(@Param("o_id") orderID: Long): Iterable<OrderHistoryEntity>

    @Query(value = "select * from order_history where order_id = :o_id", nativeQuery = true)
    fun findAllOfOrder(pageable: Pageable, @Param("o_id") orderID: Long): Page<OrderHistoryEntity>

}