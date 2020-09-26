package com.zakaion.api.entity

import org.hibernate.annotations.GenericGenerator
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedDate
import java.util.*
import javax.persistence.*

@Entity(name = "order")
data class OrderEntity(
        @Id
        @GeneratedValue(generator="system-uuid")
        @GenericGenerator(name="system-uuid", strategy = "uuid")
        val id: String = "",
        @OneToOne
        @JoinColumn(name = "app_id", nullable = false)
        var app: AppEntity,
        @OneToOne
        @JoinColumn(name = "category_id", nullable = false)
        var category: CategoryEntity,
        @OneToOne
        @JoinColumn(name = "client_id", nullable = false)
        var client: UserEntity,
        @OneToOne
        @JoinColumn(name = "executor_id", nullable = true)
        var executor: UserEntity?,
        @OneToOne
        @JoinColumn(name = "executor_agent_id", nullable = true)
        var executorAgent: UserEntity?,
        val content: String,
        var status: String,
        @Temporal(TemporalType.TIMESTAMP)
        @CreatedDate
        val creationDateTime: Date = Date(),
        @Temporal(TemporalType.TIMESTAMP)
        @LastModifiedDate
        val modifiedDateTime: Date = Date()
)

enum class OrderStatus(val data: String) {
        PROCESS("process"),
        EXECUTING("executing"),
        CANCEL("cancel"),
        DONE("done")
}