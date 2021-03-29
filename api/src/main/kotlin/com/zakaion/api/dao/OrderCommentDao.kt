package com.zakaion.api.dao

import com.zakaion.api.entity.order.OrderComment
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface OrderCommentDao : PagingAndSortingRepository<OrderComment, Long> {

    @Query("select * from order_comment where order_id = :order_id order by creation_date_time desc", nativeQuery = true)
    fun findAll(@Param("order_id") orderID: Long, pageable: Pageable): Page<OrderComment>

}