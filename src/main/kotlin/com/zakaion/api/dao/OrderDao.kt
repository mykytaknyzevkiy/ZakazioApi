package com.zakaion.api.dao

import com.zakaion.api.entity.OrderEntity
import org.springframework.data.repository.CrudRepository

interface OrderDao : CrudRepository<OrderEntity, String>