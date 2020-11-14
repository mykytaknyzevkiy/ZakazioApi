package com.zakaion.api.model

data class PassportModel(
        val serial: String,
        val number: String,
        val date_begin: String,
        val files: List<String>
)