package com.zakaion.api.entity.executor

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.user.UserEntity
import org.hibernate.annotations.CreationTimestamp
import java.util.*
import javax.persistence.*

@Entity
data class PortfolioEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        @OneToOne
        @JsonProperty( value = "user", access = JsonProperty.Access.WRITE_ONLY)
        val user: UserEntity,
        var wallpaper: String,
        var label: String,
        var description: String,
        @ElementCollection
        val imageSlides: List<String>,
        @CreationTimestamp
        @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
        val creationDateTime: Date = Date()
)