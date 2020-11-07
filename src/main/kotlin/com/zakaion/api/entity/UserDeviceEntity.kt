package com.zakaion.api.entity

import com.zakaion.api.entity.user.UserEntity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.OneToOne

data class UserDeviceEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        val name: String,
        @OneToOne
        val user: UserEntity,
        val fmcToken: String
)