package com.zakaion.api.dao

import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.repository.query.Param

interface CityDao : PagingAndSortingRepository<CityEntity, Long> {

    @Query(value = "select * from city where name like %:name%", nativeQuery = true)
    fun search(@Param("name") name: String, pageable: Pageable) : Page<CityEntity>

    @Query(value = "select * from city where region_id = :regionID", nativeQuery = true)
    fun findAll(@Param("regionID") regionID: Long, pageable: Pageable) : Page<CityEntity>

    @Query(value = "select * from city where region_id = :regionID and name like %:name%", nativeQuery = true)
    fun search(@Param("name") name: String,
               @Param("regionID") regionID: Long,
               pageable: Pageable) : Page<CityEntity>
}