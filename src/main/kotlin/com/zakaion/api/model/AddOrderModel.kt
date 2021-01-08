package com.zakaion.api.model

import com.fasterxml.jackson.annotation.JsonProperty

data class AddOrderModel(
        val title: String,
        val content: String,
        val price: Float,
        val dateLine: String,
        val cityID: Long,

        val executorID: Long? = null,

        @JsonProperty("client_first_name")
        val clientFirstName: String = "",
        @JsonProperty("client_last_name")
        val clientLastName: String = "",
        @JsonProperty("client_middle_name")
        val clientMiddleName: String = "",
        @JsonProperty("client_phone")
        val clientPhone: String = "",
        @JsonProperty("client_email")
        val clientEmail: String = "",

        val files: List<String> = emptyList()
)