package com.zakaion.api.dao

import com.zakaion.api.entity.region.RegionEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface RegionDao : PagingAndSortingRepository<RegionEntity, Long> {

    @Query(value = "select * from region where name like %:name%", nativeQuery = true)
    fun search(@Param("name") name: String, pageable: Pageable) : Page<RegionEntity>

}