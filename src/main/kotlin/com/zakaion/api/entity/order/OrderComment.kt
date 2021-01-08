package com.zakaion.api.entity.order

import com.zakaion.api.entity.user.UserEntity
import org.hibernate.annotations.CreationTimestamp
import java.util.*
import javax.persistence.*

@Entity(name = "order_comment")
data class OrderComment(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,

        @OneToOne
        val user: UserEntity,

        @OneToOne
        val order: OrderEntity,

        val comment: String,

        @CreationTimestamp
        @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val creationDateTime: Date = Date()
)