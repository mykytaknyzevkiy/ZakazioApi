package com.zakaion.api.entity.user

import javax.persistence.*

@Entity(name = "user_device")
data class UserDeviceEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        val name: String,
        @OneToOne
        val user: UserEntity,
        val fmcToken: String
)