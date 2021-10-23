package com.zakaion.api.entity

import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import java.util.*
import javax.persistence.*

@Entity(name = "tinkoff_payment")
data class TinkoffPaymentEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    val id: Long = 0L,

    val paymentID: String,

    val amount: Float,

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

    @Query(value = "select * from tinkoff_payment where paymentID = :paymentID", nativeQuery = true)
    fun findByPaymentID(@Param("paymentID") paymentID: String): Optional<TinkoffPaymentEntity>

}