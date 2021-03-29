package com.zakaion.api.entity.transaction

import com.zakaion.api.entity.card.BankCardEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import org.hibernate.annotations.CreationTimestamp
import java.util.*
import javax.persistence.*

@Entity(name = "transaction_in")
data class TransactionInEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        override val id: Long = 0,

        override val amount: Float,

        @OneToOne
        override val user: UserEntity,

        @OneToOne
        override val card: BankCardEntity?,

        @OneToOne
        override val order: OrderEntity?,

        @CreationTimestamp
        @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        override val creationDateTime: Date = Date()
) : TransactionImp