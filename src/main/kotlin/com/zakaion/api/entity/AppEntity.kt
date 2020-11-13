package com.zakaion.api.entity

import com.zakaion.api.entity.user.UserEntity
import javax.persistence.*

@Entity(name = "app")
data class AppEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        val name: String,
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val key: String,
        @OneToOne
        val owner: UserEntity
)