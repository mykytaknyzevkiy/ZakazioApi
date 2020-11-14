package com.zakaion.api.dao

import com.zakaion.api.entity.order.OrderEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface OrderDao : PagingAndSortingRepository<OrderEntity, Long>