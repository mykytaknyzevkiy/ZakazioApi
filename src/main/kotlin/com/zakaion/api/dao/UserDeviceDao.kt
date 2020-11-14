package com.zakaion.api.dao

import com.zakaion.api.entity.user.UserDeviceEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface UserDeviceDao : PagingAndSortingRepository<UserDeviceEntity, Long>