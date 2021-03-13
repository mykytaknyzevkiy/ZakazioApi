package com.zakaion.api.dao

import com.zakaion.api.entity.executor.PortfolioEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface PortfolioDao : PagingAndSortingRepository<PortfolioEntity, Long> {

    @Query(value = "select * from portfolio_entity where user_id = :userID", nativeQuery = true)
    fun user(@Param("userID") userID: Long, pageable: Pageable) : Page<PortfolioEntity>

    @Query(value = "select * from portfolio_entity where user_id = :userID", nativeQuery = true)
    fun user(@Param("userID") userID: Long) : Iterable<PortfolioEntity>

}