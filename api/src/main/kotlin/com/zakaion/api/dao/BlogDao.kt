package com.zakaion.api.dao

import com.zakaion.api.entity.blog.BlogEntity
import org.springframework.data.repository.PagingAndSortingRepository

interface BlogDao : PagingAndSortingRepository<BlogEntity, Long> {}