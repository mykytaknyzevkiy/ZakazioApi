package com.zakaion.api.entity.order

import com.zakaion.api.entity.user.UserEntity
import org.hibernate.annotations.CreationTimestamp
import org.hibernate.annotations.UpdateTimestamp
import java.util.*
import javax.persistence.*

@Entity(name = "order_n")
data class OrderEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        @Enumerated
        val status: OrderStatus,
        @OneToOne
        val client: UserEntity,
        @OneToOne
        val app: AppEntity? = null,
        @OneToOne
        val partner: UserEntity? = null,
        @OneToOne
        val executor: UserEntity? = null,
        val content: String,
        val price: Float,
        val dateLine: String,
        @CreationTimestamp
        @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val creationDateTime: Date = Date(),
        @UpdateTimestamp
        @Column(name = "modified_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val modifiedDateTime: Date = Date()
)

enum class OrderStatus(val data: String) {
    PROCESS("process"),
    IN_WORK("in_work"),
    DONE("done"),
    CANCEL("cancel")
}