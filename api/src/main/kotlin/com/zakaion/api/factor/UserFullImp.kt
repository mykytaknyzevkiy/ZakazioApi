package com.zakaion.api.factor

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.executor.PassportInfo
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp
import com.zakaion.api.entity.user.UserStatus

abstract class UserFullImp(user: UserEntity,
                           override var passport: PassportInfo?,
                           override var passportInProgress: Boolean = false,
                           var status: UserStatus = UserStatus.ACTIVE,
                           var balance: Float = 0f) : UserImp by user, UserResponseImp

data class UserFull(
                    @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
                    override val user: UserEntity,
                    override var passport: PassportInfo?) : UserFullImp(user, passport)