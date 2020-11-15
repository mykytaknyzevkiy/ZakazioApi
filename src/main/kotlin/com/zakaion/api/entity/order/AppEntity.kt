package com.zakaion.api.entity.order

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

@Entity(name = "app_n")
data class AppEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0,
        var name: String,
        val key: String,
        val masterID: Long
)