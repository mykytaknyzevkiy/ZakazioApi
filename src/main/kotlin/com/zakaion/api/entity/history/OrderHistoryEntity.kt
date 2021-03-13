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
    @CreationTimestamp
    @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    override val creationDateTime: Date = Date()
    ) : HistoryImp
