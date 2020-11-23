package com.zakaion.api.entity.order

import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.*

@Entity(name = "app_n")
data class AppEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        @Column(name = "name_n")
        var name: String,
        @Column(name = "key_n")
        val key: String,
        @JsonProperty( value = "masterID", access = JsonProperty.Access.WRITE_ONLY)
        val masterID: Long
)