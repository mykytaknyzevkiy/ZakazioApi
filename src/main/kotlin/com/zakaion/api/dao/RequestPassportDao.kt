package com.zakaion.api.dao

import com.zakaion.api.entity.RequestPassportEntity
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository

interface RequestPassportDao : PagingAndSortingRepository<RequestPassportEntity, Long>