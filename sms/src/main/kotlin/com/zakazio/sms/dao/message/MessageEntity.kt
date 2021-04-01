package com.zakazio.sms.dao.message

import com.zakazio.sms.dao.AbstractEntity
import com.zakazio.sms.dao.device.DeviceEntity
import javax.persistence.*

@Entity(name = "message")
data class MessageEntity(
    val phoneNumber: String,

    @Lob
    @Column(name = "content", length = 1024)
    val content: String,

    @Enumerated
    var status: MessageStatus = MessageStatus.OPEN,

    @OneToOne
    var worker: DeviceEntity? = null
): AbstractEntity()

enum class MessageStatus {
    OPEN,
    PROCESS,
    ERROR,
    DONE
}