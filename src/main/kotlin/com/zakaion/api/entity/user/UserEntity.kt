package com.zakaion.api.entity.user

import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.*

@Entity(name = "user")
data class UserEntity(@Id
                      @GeneratedValue(strategy= GenerationType.AUTO)
                      override val id: Long,
                      override var firstName: String,
                      override var lastName: String,
                      override var middleName: String,
                      override var avatar: String? = null,
                      override var email: String,
                      override var phoneNumber: String,
                      @JsonProperty( value = "password", access = JsonProperty.Access.WRITE_ONLY)
                      override val password: String = "",
                      @Enumerated override val role: RoleType = RoleType.CLIENT,
                      override var isEmailActive: Boolean,
                      override var isPhoneActive: Boolean,
                      override var isPassportActive: Boolean,
                      @JsonProperty( value = "masterID", access = JsonProperty.Access.WRITE_ONLY) val masterID: Long? = null) : UserImp