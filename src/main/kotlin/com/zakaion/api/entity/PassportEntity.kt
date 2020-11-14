package com.zakaion.api.entity

import com.zakaion.api.entity.user.UserEntity
import javax.persistence.*

@Entity
data class PassportEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        @OneToOne
        val user: UserEntity,
        val serial: String,
        val number: String,
        val date_begin: String,
        @ElementCollection
        val files: List<String>
)