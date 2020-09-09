package com.zakaion.api.dao

import com.zakaion.api.entity.UserEntity
import org.springframework.data.repository.CrudRepository

interface UserDao : CrudRepository<UserEntity, String>