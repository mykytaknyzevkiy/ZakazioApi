package com.zakaion.api.model

import com.zakaion.api.entity.user.UserImp
import java.util.*

data class FeedbackResponse(
    val id: Long,
    val comment: String,
    val stars: Int,
    val creationDateTime: Date,
    val user: UserImp,
    val order: OrderNModel
)
