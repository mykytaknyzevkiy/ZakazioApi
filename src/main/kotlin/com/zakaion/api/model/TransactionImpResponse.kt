package com.zakaion.api.model

import com.zakaion.api.entity.card.BankCardEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.transaction.TransactionImp
import com.zakaion.api.entity.user.UserEntity
import java.util.*

data class TransactionImpResponse(
    val id: Long,
    val amount: Float,
    val user: UserEntity,
    val card: BankCardEntity?,
    val order: OrderNModel?,
    val creationDateTime: Date,
    val operation: TransactionOperation
)

enum class TransactionOperation {
    PLUS,
    MINUS
}