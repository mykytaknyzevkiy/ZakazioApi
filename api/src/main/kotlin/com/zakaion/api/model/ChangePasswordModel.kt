package com.zakaion.api.model

data class ChangePasswordModel(
        val oldPassword: String?,
        val newPassword: String
)