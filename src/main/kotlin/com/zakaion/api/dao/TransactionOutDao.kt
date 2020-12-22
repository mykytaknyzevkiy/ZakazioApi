package com.zakaion.api.dao

import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.entity.transaction.TransactionOutEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface TransactionOutDao : PagingAndSortingRepository<TransactionOutEntity, Long> {

    @Query(value = "select * from transaction_out user_id = :userID", nativeQuery = true)
    fun find(@Param("userID") userID: Long, pageable: Pageable) : Page<TransactionOutEntity>

    @Query(value = "select * from transaction_out user_id = :userID", nativeQuery = true)
    fun find(@Param("userID") userID: Long) : Iterable<TransactionOutEntity>

    @Query(value = "select * from transaction_out order_id = :orderID", nativeQuery = true)
    fun findOrder(@Param("orderID") orderID: Long) : Iterable<TransactionInEntity>

}