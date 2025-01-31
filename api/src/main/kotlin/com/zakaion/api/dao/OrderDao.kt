package com.zakaion.api.dao

import com.zakaion.api.entity.order.OrderEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface OrderDao : PagingAndSortingRepository<OrderEntity, Long> {

    @Query(value = "select * from order_n where (client_id = :first_u_id or executor_id = :first_u_id or partner_id = :first_u_id) and (client_id = :second_u_id or executor_id = :second_u_id or partner_id = :second_u_id)", nativeQuery = true)
    fun findFriendOrders(@Param("first_u_id") firstUserId: Long,
                         @Param("second_u_id") secondUserId: Long): Iterable<OrderEntity>

    @Query(value = "update order_n set executor_id = :executor_id where id = :order_id", nativeQuery = true)
    fun setExecutor(@Param("order_id") orderID: Long, @Param("executor_id") executorID: Long)

    @Query(value = "select * from order_n where (client_id = :u_id or executor_id = :u_id or partner_id = :u_id) order by creation_date_time desc", nativeQuery = true)
    fun findUserOrders(pageable: Pageable, @Param("u_id") userID: Long): Page<OrderEntity>

    @Query(value = "select * from order_n where (client_id = :u_id or executor_id = :u_id or partner_id = :u_id) order by creation_date_time desc", nativeQuery = true)
    fun findUserOrders(@Param("u_id") userID: Long): Iterable<OrderEntity>

    @Query(value = "select * from order_n where (client_id = :u_id or executor_id = :u_id or partner_id = :u_id) and (title like %:search% or content like %:search%) order by creation_date_time desc", nativeQuery = true)
    fun findUserOrders(pageable: Pageable, @Param("u_id") userID: Long, @Param("search") search: String): Page<OrderEntity>

    @Query(value = "select * from order_n where (title like %:search% or content like %:search%) and (city_id = :city_id or :city_id = -1) and (category_id = :category_id or :category_id = -1) and (child_category_id = :child_category_id or :child_category_id = -1) order by creation_date_time desc", nativeQuery = true)
    fun findAll(pageable: Pageable,
                @Param("search") search: String,
                @Param("city_id") cityID: Long,
                @Param("category_id") categoryID: Long,
                @Param("child_category_id") childCategoryID: Long) : Page<OrderEntity>

    @Query(value = "select * from order_n where executor_id IS NULL and (title like %:search% or content like %:search%) and (city_id = :city_id or :city_id = -1) and (category_id = :category_id or :category_id = -1) and (child_category_id = :child_category_id or :child_category_id = -1) order by creation_date_time desc", nativeQuery = true)
    fun findFreeAll(pageable: Pageable,
                @Param("search") search: String,
                @Param("city_id") cityID: Long,
                @Param("category_id") categoryID: Long,
                @Param("child_category_id") childCategoryID: Long) : Page<OrderEntity>

    @Query(value = "select * from order_n where creation_date_time BETWEEN :startDate and :endDate order by creation_date_time desc", nativeQuery = true)
    fun findAll(@Param("startDate") startDate: Date, @Param("endDate") endDate: Date) : Iterable<OrderEntity>

    @Query(value = "select * from order_n order by creation_date_time desc", nativeQuery = true)
    override fun findAll(pageable: Pageable): Page<OrderEntity>

    @Query(value = "select * from order_n where app_id = :app_id order by creation_date_time desc", nativeQuery = true)
    fun findAppOrders(pageable: Pageable, @Param("app_id") appID: Long): Page<OrderEntity>

    @Query(value = "select * from order_n where app_id = :app_id order by creation_date_time desc", nativeQuery = true)
    fun findAppOrders(@Param("app_id") appID: Long): Iterable<OrderEntity>
}