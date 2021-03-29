package com.zakaion.api.dao

import com.zakaion.api.entity.help.HelpMessageEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface HelpMessageDao : PagingAndSortingRepository<HelpMessageEntity, Long> {
}