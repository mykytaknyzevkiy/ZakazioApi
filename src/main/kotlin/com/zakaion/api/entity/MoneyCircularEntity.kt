package com.zakaion.api.entity

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
data class MoneyCircularEntity(
        @Id
        @GeneratedValue
        val id: Int = 0,
        val fromExecutor: Int = 15,
        val executorPartner: Int = 6,
        val orderPartner: Int = 6,
        val project: Int = 0
)