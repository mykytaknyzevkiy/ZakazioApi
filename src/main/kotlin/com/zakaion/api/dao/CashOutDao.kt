package com.zakaion.api.dao

import com.zakaion.api.entity.CashInEntity
import com.zakaion.api.entity.CashOutEntity
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface CashOutDao : CrudRepository<CashOutEntity, Long> {

    @Query("select * from cash_out where creation_date_time >= :startDate and creation_date_time <= :endDate", nativeQuery = true)
    fun findAllByDate(@Param("startDate") startDate: Date,
                      @Param("endDate") endDate: Date)
            : List<CashInEntity>

}