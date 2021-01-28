package com.zakaion.api.entity.user

import com.zakaion.api.entity.region.CityEntity

interface UserImp {
    val id: Long
    val firstName: String
    val lastName: String
    val middleName: String
    var avatar: String?
    var email: String?
    var phoneNumber: String?
    val role: RoleType?
    val isEmailActive: Boolean
    var isPhoneActive: Boolean
    val isPassportActive: Boolean
    val masterID: Long?
    var city: CityEntity?
    var status: UserStatus?
}

enum class UserStatus {
    ACTIVE,
    BLOCKED,
    PROCESS
}