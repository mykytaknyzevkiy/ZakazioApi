package com.zakaion.api.dao

import com.zakaion.api.entity.order.AppEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface AppDao : PagingAndSortingRepository<AppEntity, Long>