package com.zakaion.api.factor.user

import com.zakaion.api.factor.UserFull
import com.zakaion.api.factor.UserFullImp
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.entity.user.UserEntity

class ZakazioUserFactory (user: UserEntity, private val passportDao: PassportDao) : UserImpFactor(user) {

    override fun create(): UserFullImp {
        return UserFull(user, passportDao.findAll().find { it.user.id == user.id })
    }
}