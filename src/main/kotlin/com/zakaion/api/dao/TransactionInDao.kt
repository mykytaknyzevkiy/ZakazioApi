package com.zakaion.api.dao

import com.zakaion.api.entity.transaction.TransactionInEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface TransactionInDao : PagingAndSortingRepository<TransactionInEntity, Long> {

    @Query(value = "select * from transaction_in where user_id = :userID", nativeQuery = true)
    fun find(@Param("userID") userID: Long, pageable: Pageable) : Page<TransactionInEntity>

    @Query(value = "select * from transaction_in where user_id = :userID", nativeQuery = true)
    fun find(@Param("userID") userID: Long) : Iterable<TransactionInEntity>

    @Query(value = "select * from transaction_in where order_id = :orderID", nativeQuery = true)
    fun findOrder(@Param("orderID") orderID: Long) : Iterable<TransactionInEntity>

}