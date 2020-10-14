package com.zakaion.api.dao

import com.zakaion.api.entity.PhoneVerificationEntity
import org.springframework.data.repository.CrudRepository

interface PhoneVerificationDao : CrudRepository<PhoneVerificationEntity, String>