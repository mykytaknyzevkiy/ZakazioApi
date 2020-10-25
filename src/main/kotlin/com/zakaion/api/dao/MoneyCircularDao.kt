package com.zakaion.api.dao

import com.zakaion.api.entity.MoneyCircularEntity
import org.springframework.data.repository.CrudRepository

interface MoneyCircularDao : CrudRepository<MoneyCircularEntity, Long>