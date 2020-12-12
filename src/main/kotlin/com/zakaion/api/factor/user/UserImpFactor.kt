package com.zakaion.api.factor.user

import com.zakaion.api.factor.UserFullImp
import com.zakaion.api.entity.user.UserEntity

abstract class UserImpFactor(protected val user: UserEntity) {

    abstract fun create() : UserFullImp

}