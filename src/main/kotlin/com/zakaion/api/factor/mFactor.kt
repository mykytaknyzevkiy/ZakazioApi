package com.zakaion.api.factor

import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import org.springframework.security.core.context.SecurityContextHolder

abstract class MFactor {
    val myUser: UserEntity
        get() {
            val realUser = SecurityContextHolder
                    .getContext()
                    .authentication
                    .principal as? UserEntity?

            return realUser ?: UserEntity(-1000,
                    "Anon",
                    "Anon",
                    "Anon",
                    null,
                    "anon@zakazio.com",
                    "000000",
                    "",
                    RoleType.CLIENT
            )
        }
}