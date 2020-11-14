package com.zakaion.api.dao

import com.zakaion.api.entity.executor.PassportEntity
import org.springframework.data.repository.CrudRepository

interface PassportDao : CrudRepository<PassportEntity, Long>