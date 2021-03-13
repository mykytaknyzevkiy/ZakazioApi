package com.zakaion.api.dao

import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.entity.transaction.TransactionOutEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface TransactionOutDao : PagingAndSortingRepository<TransactionOutEntity, Long> {

    @Query(value = "select * from transaction_out where user_id = :userID", nativeQuery = true)
    fun find(@Param("userID") userID: Long, pageable: Pageable) : Page<TransactionOutEntity>

    @Query(value = "select * from transaction_out where user_id = :userID", nativeQuery = true)
    fun find(@Param("userID") userID: Long) : Iterable<TransactionOutEntity>

    @Query(value = "select * from transaction_out where order_id = :orderID", nativeQuery = true)
    fun findOrder(@Param("orderID") orderID: Long) : Iterable<TransactionOutEntity>

    @Query(value = "select * from transaction_out where creation_date_time BETWEEN :startDate and :endDate", nativeQuery = true)
    fun findAll(@Param("startDate") startDate: Date, @Param("endDate") endDate: Date) : Iterable<TransactionOutEntity>

}