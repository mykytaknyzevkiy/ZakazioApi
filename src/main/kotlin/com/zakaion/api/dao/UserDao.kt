package com.zakaion.api.dao

import com.zakaion.api.entity.user.UserEntity
import org.springframework.data.repository.CrudRepository

interface UserDao : CrudRepository<UserEntity, Long>