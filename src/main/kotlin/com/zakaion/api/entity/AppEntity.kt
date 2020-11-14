package com.zakaion.api.entity

import com.zakaion.api.entity.user.UserEntity
import javax.persistence.*

@Entity(name = "app_n")
data class AppEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long,
        val name_n: String,
        val key_n: String,
        val masterID: String
)