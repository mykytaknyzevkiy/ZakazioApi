package com.zakaion.api.entity.user

interface UserImp {
    val id: Long
    val firstName: String
    val lastName: String
    val middleName: String
    val email: String
    val phoneNumber: String
    val password: String

    val role: RoleType

    val isEmailActive: Boolean
    val isPhoneActive: Boolean
    val isPassportActive: Boolean
}