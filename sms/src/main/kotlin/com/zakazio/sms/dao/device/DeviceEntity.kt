package com.zakazio.sms.dao.device

import com.zakazio.sms.dao.AbstractEntity
import javax.persistence.Entity

@Entity(name = "device")
data class DeviceEntity(
    var maxSms: Int,

    var name: String
): AbstractEntity()