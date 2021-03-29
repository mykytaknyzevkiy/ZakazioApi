package com.zakaion.api.entity.history

import com.zakaion.api.entity.user.UserEntity
import java.util.*

interface HistoryImp {
    val id: Long
    val user: UserEntity
    val data: String
    val creationDateTime: Date
}