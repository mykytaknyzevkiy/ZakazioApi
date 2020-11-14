package com.zakaion.api.dao

import com.zakaion.api.entity.OrderEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface OrderDao : PagingAndSortingRepository<OrderEntity, Long>