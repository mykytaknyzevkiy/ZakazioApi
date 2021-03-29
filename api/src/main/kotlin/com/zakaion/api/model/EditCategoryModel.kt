package com.zakaion.api.model

data class EditCategoryModel(
        val name: String,
        val isActive: Boolean = true,
        val image: String?
)