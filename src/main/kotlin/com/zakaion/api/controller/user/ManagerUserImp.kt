package com.zakaion.api.controller.user

import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.user.UserEntity

abstract class ManagerUserImp(user: UserEntity,
                              override var passport: PassportEntity?) : UserFullImp(user, passport), OrderUserImp