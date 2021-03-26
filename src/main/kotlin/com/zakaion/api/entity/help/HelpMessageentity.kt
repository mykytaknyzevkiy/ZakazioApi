package com.zakaion.api.entity.help

import com.zakaion.api.entity.user.UserEntity
import javax.persistence.*

@Entity(name = "help_message")
data class HelpMessageEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    val id: Long = 0L,

    @OneToOne
    val user: UserEntity,

    @Lob
    @Column(name = "message", length = 1024)
    val message: String,
)
