package com.zakaion.api.model

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.factor.FullOrderClientImp
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity

data class ExecutorInfo(
        @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
        override val user: UserEntity,
        override val rate: Float,
        override val order: UserOrder,
        override var passport: PassportEntity?
): FullOrderClientImp(user, passport)