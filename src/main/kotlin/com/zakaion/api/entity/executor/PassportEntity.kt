package com.zakaion.api.entity.executor

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.user.UserEntity
import javax.persistence.*

@Entity
data class PassportEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        @OneToOne
        @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
        val user: UserEntity,
        val serial: String,
        val number: String,
        val date_begin: String,
        val taxID: String,
        @ElementCollection
        val files: List<String>
)