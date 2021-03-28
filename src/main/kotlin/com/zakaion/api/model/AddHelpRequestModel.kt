package com.zakaion.api.model

data class AddHelpRequestModel(
    val message: String,

    val files: List<String>,
)
