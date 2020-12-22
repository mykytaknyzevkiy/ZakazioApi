package com.zakaion.api.entity.transaction

import com.zakaion.api.entity.card.BankCardEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import java.util.*

interface TransactionImp {
    val id: Long
    val amount: Float
    val user: UserEntity
    val card: BankCardEntity?
    val order: OrderEntity?
    val creationDateTime: Date
}