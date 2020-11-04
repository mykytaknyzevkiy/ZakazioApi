package com.zakaion.api.entity

import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

data class CategoryEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        var name: String,
        var imageUrl: String? = null,
        var isActive: Boolean = false
)