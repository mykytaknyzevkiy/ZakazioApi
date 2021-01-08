package com.zakaion.api.model

import com.zakaion.api.entity.user.UserEntity
import java.util.*

data class OrderCommentModel(
        val id: Long = 0,

        val text: String,

        val user: UserEntity? = null,

        val creationDateTime: Date? = Date()
)