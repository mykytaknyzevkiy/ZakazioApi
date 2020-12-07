package com.zakaion.api.entity.user

import com.fasterxml.jackson.annotation.JsonProperty
import com.zakaion.api.entity.region.CityEntity
import javax.persistence.*

@Entity(name = "user")
data class UserEntity(@Id
                      @GeneratedValue(strategy= GenerationType.AUTO)
                      override val id: Long = 0,
                      override var firstName: String,
                      override var lastName: String,
                      override var middleName: String,
                      override var avatar: String? = null,
                      override var email: String?,
                      override var phoneNumber: String?,
                      @JsonProperty( value = "password", access = JsonProperty.Access.WRITE_ONLY)
                      var password: String = "",
                      @Enumerated override val role: RoleType = RoleType.CLIENT,
                      override var isEmailActive: Boolean = false,
                      override var isPhoneActive: Boolean = false,
                      override var isPassportActive: Boolean = false,
                      @JsonProperty( value = "masterID", access = JsonProperty.Access.WRITE_ONLY)
                      override val masterID: Long? = null,
                      @OneToOne
                      override var city: CityEntity? = null) : UserImp