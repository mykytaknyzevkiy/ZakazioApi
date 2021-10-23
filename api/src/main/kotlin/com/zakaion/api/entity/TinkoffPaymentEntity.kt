package com.zakaion.api.entity

import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import org.springframework.data.repository.CrudRepository
import javax.persistence.*

@Entity(name = "tinkoff_payment")
data class TinkoffPaymentEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    val id: Long = 0L,

    val paymentID: String,

    @OneToOne
    val user: UserEntity,

    @OneToOne
    val order: OrderEntity,

    @Enumerated
    val status: TinkoffPaymentStatus = TinkoffPaymentStatus.NEW
)

enum class TinkoffPaymentStatus {
    NEW,
    FAIL,
    CONFIRM
}

interface TinkoffPaymentDao : CrudRepository<TinkoffPaymentEntity, Long> {

}