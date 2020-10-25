package com.zakaion.api.dao

import com.zakaion.api.entity.OrderHistoryEntity
import org.springframework.data.repository.CrudRepository

interface OrderHistoryDao : CrudRepository<OrderHistoryEntity, Long>