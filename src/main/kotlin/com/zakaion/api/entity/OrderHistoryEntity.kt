package com.zakaion.api.entity

import org.hibernate.annotations.CreationTimestamp
import org.hibernate.annotations.GenericGenerator
import java.util.*
import javax.persistence.*

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
        val data: String,
        @CreationTimestamp
        @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val creationDateTime: Date = Date()
)