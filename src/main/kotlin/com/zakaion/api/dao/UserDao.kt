package com.zakaion.api.dao

import com.zakaion.api.entity.UserEntity
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository

interface UserDao : PagingAndSortingRepository<UserEntity, String>