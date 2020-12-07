package com.zakaion.api.model

import com.zakaion.api.controller.user.FullOrderClientImp
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp

data class ClientInfo(
        override val user: UserEntity,
        override val rate: Float,
        override val order: UserOrder,
        override var passport: PassportEntity?
) : FullOrderClientImp(user, passport)