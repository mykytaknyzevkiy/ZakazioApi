package com.zakaion.api.model

data class EditOrderModel(
        val title: String,
        val content: String,
        val price: Float,
        val files: List<String> = emptyList(),
        val dateLine: String
)