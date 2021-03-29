package com.zakaion.api.dao

import com.zakaion.api.entity.card.BankCardEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface BankCardDao : PagingAndSortingRepository<BankCardEntity, Long> {

    @Query("select * from bank_card where user_id = :userID", nativeQuery = true)
    fun userCards(@Param("userID") userID: Long, pageable: Pageable) : Page<BankCardEntity>

}