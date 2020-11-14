package com.zakaion.api.dao

import com.zakaion.api.entity.executor.RequestPassportEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface RequestPassportDao : PagingAndSortingRepository<RequestPassportEntity, Long>