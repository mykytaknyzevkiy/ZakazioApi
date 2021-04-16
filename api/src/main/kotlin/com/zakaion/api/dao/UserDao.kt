package com.zakaion.api.dao

import com.zakaion.api.entity.user.UserEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface UserDao : PagingAndSortingRepository<UserEntity, Long> {

    @Query(value = "select * from user where role = :role", nativeQuery = true)
    fun findByRole(@Param("role") roleType: Int, pageable: Pageable) : Page<UserEntity>

    @Query(value = "select * from user where role = :role", nativeQuery = true)
    fun findByRole(@Param("role") roleType: Int) : Iterable<UserEntity>

    @Query(value = "select * from user where role = :role and masterID = :masterID", nativeQuery = true)
    fun findByRole(@Param("role") roleType: Int,
                           @Param("masterID") masterID: Long,
                           pageable: Pageable) : Page<UserEntity>

    @Query(value = "select * from user where role = :role and masterID = :masterID", nativeQuery = true)
    fun findByRole(@Param("role") roleType: Int,
                   @Param("masterID") masterID: Long) : Iterable<UserEntity>

    @Query(value = "select * from user where role = :role and (email like %:search% or first_name like %:search% or last_name like %:search% or middle_name like %:search% or phone_number like %:search%)", nativeQuery = true)
    fun findByRole(@Param("role") roleType: Int,
                   @Param("search") search: String,
                   pageable: Pageable) : Page<UserEntity>

    @Query(value = "select * from user where role = :role and masterID = :masterID and (email like %:search% or first_name like %:search% or last_name like %:search% or middle_name like %:search% or phone_number like %:search%)", nativeQuery = true)
    fun findByRole(@Param("role") roleType: Int,
                   @Param("masterID") masterID: Long,
                   @Param("search") search: String,
                   pageable: Pageable) : Page<UserEntity>

    @Query(value = "select * from user where creation_date_time BETWEEN :startDate and :endDate", nativeQuery = true)
    fun findAll(@Param("startDate") startDate: Date, @Param("endDate") endDate: Date) : Iterable<UserEntity>

}