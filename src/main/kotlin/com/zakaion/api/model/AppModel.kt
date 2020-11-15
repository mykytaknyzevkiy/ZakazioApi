package com.zakaion.api.model

import com.zakaion.api.entity.user.UserEntity

data class AppModel(
        val id: Long = 0,
        val name: String,
        val key: String = "",
        val owner: UserEntity? = null
)