package com.zakaion.api.model

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp

data class ExecutorInfo(
        @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
        val user: UserEntity,
        val rate: Float,
        val order: UserOrder

) : UserImp by user