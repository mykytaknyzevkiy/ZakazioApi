package com.zakaion.api.entity.user

import javax.persistence.Entity
import javax.persistence.Enumerated
import javax.persistence.Id

@Entity(name = "user")
data class UserEntity(@Id override val id: Long,
                      override val firstName: String,
                      override val lastName: String,
                      override val middleName: String,
                      override val email: String,
                      override val phoneNumber: String,
                      override val password: String,
                      @Enumerated override val role: RoleType,
                      override val isEmailActive: Boolean,
                      override val isPhoneActive: Boolean,
                      override val isPassportActive: Boolean) : UserImp