package com.zakaion.api.entity

import org.hibernate.annotations.CreationTimestamp
import org.hibernate.annotations.GenericGenerator
import org.hibernate.annotations.UpdateTimestamp
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.format.annotation.DateTimeFormat
import java.util.*
import javax.persistence.*


@Entity
@Table(name = "order_n")
data class OrderEntity(
        @Id
        @GeneratedValue(generator="system-uuid")
        @GenericGenerator(name="system-uuid", strategy = "uuid")
        val id: String = "",
        @OneToOne
       // @JoinColumn(name = "app_id", nullable = false)
        var app: AppEntity,
        @OneToOne
       // @JoinColumn(name = "category_id", nullable = false)
        var category: CategoryEntity,
        @OneToOne
        //@JoinColumn(name = "client_id", nullable = false)
        var client: UserEntity,
        @OneToOne
       // @JoinColumn(name = "executor_id", nullable = true)
        var executor: UserEntity? = null,
        @OneToOne
       // @JoinColumn(name = "agentExecutorID", nullable = true)
        var executorAgent: UserEntity? = null,
        val content: String,
        var status: String,
        var totalPrice: Float = 0f,
        var currence: String = MoneyCurrency.RUB.data,
        @CreationTimestamp
        @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val creationDateTime: Date = Date(),
        @UpdateTimestamp
        @Column(name = "modified_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val modifiedDateTime: Date = Date()
)

enum class OrderStatus(val data: String) {
        PROCESS("process"),
        EXECUTING("executing"),
        EXECUTED("executed"),
        CANCEL("cancel"),
        DONE("done")
}

enum class MoneyCurrency(val data: String) {
        RUB("rub")
}