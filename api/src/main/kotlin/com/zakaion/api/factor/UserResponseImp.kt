package com.zakaion.api.factor

import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.executor.PassportInfo
import com.zakaion.api.entity.user.UserEntity

interface UserResponseImp {
    val user: UserEntity
    val passport: PassportInfo?
    var passportInProgress: Boolean
}