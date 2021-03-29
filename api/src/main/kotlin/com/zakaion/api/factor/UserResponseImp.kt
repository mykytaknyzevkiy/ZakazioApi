package com.zakaion.api.factor

import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity

interface UserResponseImp {
    val user: UserEntity
    val passport: PassportEntity?
    var passportInProgress: Boolean
}