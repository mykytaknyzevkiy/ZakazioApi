package com.zakaion.api.factor

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp

abstract class UserFullImp(user: UserEntity, override var passport: PassportEntity?) : UserImp by user, UserResponseImp

data class UserFull(
                    @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
                    override val user: UserEntity,
                    override var passport: PassportEntity?) : UserFullImp(user, passport)