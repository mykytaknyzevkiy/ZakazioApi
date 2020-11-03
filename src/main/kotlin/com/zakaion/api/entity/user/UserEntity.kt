package com.zakaion.api.entity.user

import com.fasterxml.jackson.annotation.JsonProperty
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
                      @JsonProperty( value = "password", access = JsonProperty.Access.WRITE_ONLY)
                      override val password: String,
                      @Enumerated override val role: RoleType = RoleType.CLIENT,
                      override val isEmailActive: Boolean,
                      override val isPhoneActive: Boolean,
                      override val isPassportActive: Boolean) : UserImp