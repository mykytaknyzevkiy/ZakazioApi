package com.zakaion.api.model

import com.zakaion.api.entity.user.UserImp

data class AppModel(
        val id: Long = 0,
        val name: String,
        val key: String = "",
        val owner: UserImp? = null,
        val order: UserOrder = UserOrder.create(emptyList())
)