package com.zakaion.api.model

import com.zakaion.api.entity.PhoneVerificationEntity

data class SignUpExecutorModel(
        val phoneVerificationId: String,
        val firstName: String,
        val lastName: String,
        val middleName: String,
        val email: String,
        val password: String
)