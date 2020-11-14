package com.zakaion.api.entity.order

import com.zakaion.api.entity.user.UserEntity
import javax.persistence.*

@Entity
data class FeedbackEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        @OneToOne
        val order: OrderEntity,
        @OneToOne
        val user: UserEntity,
        val stars: Int,
        val comments: String
)