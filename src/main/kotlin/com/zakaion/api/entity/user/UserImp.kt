package com.zakaion.api.entity.user

interface UserImp {
    val id: Long
    val firstName: String
    val lastName: String
    val middleName: String
    val avatar: String?
    var email: String?
    var phoneNumber: String?
    val role: RoleType
    val isEmailActive: Boolean
    var isPhoneActive: Boolean
    val isPassportActive: Boolean
    val masterID: Long?
}