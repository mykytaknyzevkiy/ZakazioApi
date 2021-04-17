package com.zakaion.api.entity.history

import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import org.hibernate.annotations.CreationTimestamp
import java.util.*
import javax.persistence.*

@Entity(name = "order_history")
data class OrderHistoryEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    override val id: Long = 0L,
    @OneToOne
    override val user: UserEntity,
    override val data: String,
    @OneToOne
    val order: OrderEntity,
    @Column(name = "creation_date_time", insertable = true, updatable = true)
    override val creationDateTime: Date = Date(),
    @Enumerated
    val type: OrderHistoryType
    ) : HistoryImp

enum class OrderHistoryType {
    CREATE,
    EDIT,
    BE_EXECUTOR,
    SET_EXECUTOR,
    CANCEL_EXECUTOR,
    START_WORK,
    DONE_WORK,
    CANCEL,
    SHARE_SUM
}