package com.zakaion.api.dao

import com.zakaion.api.entity.order.FeedbackEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface FeedbackDao : PagingAndSortingRepository<FeedbackEntity, Long> {

    @Query("select * from feedback where user_id = :USER_ID and order_id = :ORDER_ID", nativeQuery = true)
    fun feedBack(@Param("USER_ID") userID: Long, @Param("ORDER_ID") orderID: Long): Optional<FeedbackEntity>

    @Query("select * from feedback where user_id = :USER_ID", nativeQuery = true)
    fun feedBacks(pageable: Pageable, @Param("USER_ID") userID: Long): Page<FeedbackEntity>

}