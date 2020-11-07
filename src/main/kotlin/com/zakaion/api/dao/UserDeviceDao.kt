package com.zakaion.api.dao

import com.zakaion.api.entity.UserDeviceEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface UserDeviceDao : PagingAndSortingRepository<UserDeviceEntity, Long>