package com.zakaion.api.entity.executor

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.user.UserEntity
import org.hibernate.annotations.Proxy
import javax.persistence.*

@Entity
@Proxy(lazy = true)
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
        @ElementCollection(fetch = FetchType.LAZY)
        @JsonIgnore
        val files: List<String>
) {
        fun toInfoJson() = PassportInfo(
                id,
                serial, number, date_begin, taxID, emptyList()
        )
}

@Proxy(lazy = true)
data class PassportInfo(val id: Long = 0L,
                        val serial: String,
                        val number: String,
                        val date_begin: String,
                        val taxID: String,
                        val files: List<String>)