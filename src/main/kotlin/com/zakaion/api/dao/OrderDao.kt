package com.zakaion.api.dao

import com.zakaion.api.entity.order.OrderEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface OrderDao : PagingAndSortingRepository<OrderEntity, Long> {

    @Query(value = "select * from order_n where (client_id = :first_u_id or executor_id = :first_u_id or partner_id = :first_u_id) and (client_id = :second_u_id or executor_id = :second_u_id or partner_id = :second_u_id)", nativeQuery = true)
    fun findFriendOrders(@Param("first_u_id") firstUserId: Long,
                         @Param("second_u_id") secondUserId: Long): Iterable<OrderEntity>

    @Query(value = "select * from order_n where (client_id = :u_id or executor_id = :u_id or partner_id = :u_id)", nativeQuery = true)
    fun findUserOrders(pageable: Pageable, @Param("u_id") userID: Long): Page<OrderEntity>

    @Query(value = "select * from order_n where (client_id = :u_id or executor_id = :u_id or partner_id = :u_id)", nativeQuery = true)
    fun findUserOrders(@Param("u_id") userID: Long): Iterable<OrderEntity>

    @Query(value = "update order_n set executor_id = :executor_id where id = :order_id", nativeQuery = true)
    fun setExecutor(@Param("order_id") orderID: Long, @Param("executor_id") executorID: Long)
}