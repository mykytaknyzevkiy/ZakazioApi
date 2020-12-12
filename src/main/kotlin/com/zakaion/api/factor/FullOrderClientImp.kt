package com.zakaion.api.factor

import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity

abstract class FullOrderClientImp(override val user: UserEntity,
                                  override var passport: PassportEntity?) :
        OrderClientImp,
        OrderUserImp,
        UserFullImp(user, passport)