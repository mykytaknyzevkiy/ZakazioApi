package com.zakaion.api.entity.card

import com.zakaion.api.entity.user.UserEntity
import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.*

@Entity(name = "bank_card")
data class BankCardEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,

        @OneToOne
        val user: UserEntity,

        @JsonProperty( value = "crypto", access = JsonProperty.Access.WRITE_ONLY)
        @Column(length = 3000)
        val crypto: String,

        val endNum: String,

        val exp: String
)