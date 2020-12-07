package com.zakaion.api.model

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.controller.user.ManagerUserImp
import com.zakaion.api.controller.user.OrderUserImp
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp

data class PartnerInfo(
        @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
        override val user: UserEntity,
        override val order: UserOrder,
        override var passport: PassportEntity?
) : ManagerUserImp(user, passport)