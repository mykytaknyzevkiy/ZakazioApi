package com.zakaion.api.dao

import com.zakaion.api.entity.OrderCommentEntity
import org.springframework.data.repository.CrudRepository

interface OrderCommentDao : CrudRepository<OrderCommentEntity, String>