package com.zakaion.api.factor

import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.executor.PassportInfo
import com.zakaion.api.entity.user.UserEntity

abstract class ManagerUserImp(user: UserEntity,
                              override var passport: PassportInfo?) : UserFullImp(user, passport), OrderUserImp