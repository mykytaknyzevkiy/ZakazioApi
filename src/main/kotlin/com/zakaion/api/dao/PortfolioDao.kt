package com.zakaion.api.dao

import com.zakaion.api.entity.executor.PortfolioEntity
import org.springframework.data.domain.Page
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface PortfolioDao : PagingAndSortingRepository<PortfolioEntity, Long> {

    @Query(value = "select * from portfolio where user_id = :userID", nativeQuery = true)
    fun user(@Param("userID") userID: Long) : Page<PortfolioEntity>

}