package com.zakaion.api.entity

import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id

data class CategoryEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long,
        val name: String,
        val imageUrl: String? = null,
        val isActive: Boolean = false
)