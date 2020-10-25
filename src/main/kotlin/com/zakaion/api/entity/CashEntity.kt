package com.zakaion.api.entity

import org.hibernate.annotations.CreationTimestamp
import java.util.*
import javax.persistence.*

sealed class CashEntity(
        open val order: OrderEntity,
        open val user: UserEntity,
        open val price: Float,
        open val creationDateTime: Date = Date()
)

@Entity
@Table(name = "cash_in")
data class CashInEntity(
        @Id
        @GeneratedValue
        val id: Int = 0,
        @OneToOne
        val order: OrderEntity,
        @OneToOne
        val user: UserEntity,
        val price: Float,
        @CreationTimestamp
        @Column(name = "creation_date_time",
                columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
        )
        val creationDateTime: Date = Date()
)

@Entity
@Table(name = "cash_out")
data class CashOutEntity(
        @Id
        @GeneratedValue
        val id: Int = 0,
        @OneToOne
        val order: OrderEntity,
        @OneToOne
        val user: UserEntity,
        val price: Float,
        @CreationTimestamp
        @Column(name = "creation_date_time",
                columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
        )

        val creationDateTime: Date = Date()
)