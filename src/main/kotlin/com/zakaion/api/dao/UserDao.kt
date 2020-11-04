package com.zakaion.api.dao

import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface UserDao : PagingAndSortingRepository<UserEntity, Long> {

    @Query(value = "select u from user where u.role = :role", nativeQuery = true)
    fun findByRole(@Param("role") roleType: RoleType, pageable: Pageable) : Page<UserEntity>

    @Query(value = "select u from user where u.role = :role and u.masterID = :masterID", nativeQuery = true)
    fun findByRoleMasterID(@Param("role") roleType: RoleType,
                           @Param("masterID") masterID: Long,
                           pageable: Pageable) : Page<UserEntity>

}