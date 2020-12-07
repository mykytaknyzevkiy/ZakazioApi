package com.zakaion.api.factor.user

import com.zakaion.api.controller.user.UserFullImp
import com.zakaion.api.entity.user.UserEntity
import org.springframework.security.core.context.SecurityContextHolder

abstract class UserImpFactor(protected val user: UserEntity) {

    abstract fun create() : UserFullImp

}