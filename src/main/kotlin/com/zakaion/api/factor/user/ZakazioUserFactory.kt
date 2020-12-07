package com.zakaion.api.factor.user

import com.zakaion.api.controller.user.UserFull
import com.zakaion.api.controller.user.UserFullImp
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserImp

class ZakazioUserFactory (user: UserEntity, private val passportDao: PassportDao) : UserImpFactor(user) {

    override fun create(): UserFullImp {
        return UserFull(user, passportDao.findAll().find { it.user.id == user.id })
    }
}