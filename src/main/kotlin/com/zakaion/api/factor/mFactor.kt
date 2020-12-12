package com.zakaion.api.factor

import com.zakaion.api.entity.user.UserEntity
import org.springframework.security.core.context.SecurityContextHolder

abstract class MFactor {
    protected val myUser: UserEntity
        get() {
            return SecurityContextHolder
                    .getContext()
                    .authentication
                    .principal as UserEntity
        }
}