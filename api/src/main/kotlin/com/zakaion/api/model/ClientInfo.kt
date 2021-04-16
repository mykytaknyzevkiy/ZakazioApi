package com.zakaion.api.model

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.factor.FullOrderClientImp
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.executor.PassportInfo
import com.zakaion.api.entity.user.UserEntity

data class ClientInfo(
        @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
        override val user: UserEntity,
        override val rate: Float,
        override val order: UserOrder,
        override var passport: PassportInfo?
) : FullOrderClientImp(user, passport)