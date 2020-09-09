package com.zakaion.api.dao

import com.zakaion.api.entity.UserTokenEntity
import org.springframework.data.repository.CrudRepository

interface UserTokenDao : CrudRepository<UserTokenEntity, String>