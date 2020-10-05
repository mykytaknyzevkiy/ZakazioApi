package com.zakaion.api.entity

import org.hibernate.annotations.GenericGenerator
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne

@Entity
data class OrderHistoryEntity(
        @Id
        @GeneratedValue(generator="system-uuid")
        @GenericGenerator(name="system-uuid", strategy = "uuid")
        val id: String = "",
        @OneToOne
        val order: OrderEntity,
        @OneToOne
        val user: UserEntity,
        val operation: String,
        val data: String
)