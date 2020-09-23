package com.zakaion.api.entity

import com.fasterxml.jackson.annotation.JsonIgnore
import org.hibernate.annotations.GenericGenerator
import org.hibernate.annotations.OnDelete
import org.hibernate.annotations.OnDeleteAction
import javax.persistence.*

@Entity(name = "app")
data class AppEntity(
        @Id
        @GeneratedValue(generator="system-uuid")
        @GenericGenerator(name="system-uuid", strategy = "uuid")
        val id: String = "",
        var name: String,
        val privateKey: String,
        val publicKey: String = System.currentTimeMillis().toString(),
        @OneToOne
        @JoinColumn(name = "partner_id", nullable = false)
        val partner: UserEntity
)