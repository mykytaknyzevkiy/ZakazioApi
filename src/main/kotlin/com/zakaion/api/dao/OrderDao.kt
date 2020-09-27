package com.zakaion.api.dao

import com.zakaion.api.entity.OrderEntity
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface OrderDao : CrudRepository<OrderEntity, String> {

    @Query("select * from order_n where creation_date_time >= :startDate and creation_date_time <= :endDate", nativeQuery = true)
    fun findAllByDate(@Param("startDate") startDate: Date,
                      @Param("endDate") endDate: Date)
            : List<OrderEntity>

}