package com.zakaion.api.entity.help

import com.zakaion.api.entity.user.UserEntity
import java.util.*
import javax.persistence.*

@Entity(name = "help_message")
data class HelpMessageEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    val id: Long = 0L,

    @OneToOne
    val user: UserEntity,

    @Lob
    @Column(name = "message", length = 1024)
    val message: String,

    @ElementCollection
    val files: List<String>,

    @Enumerated
    val status: HelpStatus = HelpStatus.OPEN,

    @OneToOne
    val worker: UserEntity? = null,

    @Column(name = "creation_date_time", insertable = true, updatable = true/*, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"*/)
    //@CreationTimestamp
    val creationDateTime: Date = Date(),
)

enum class HelpStatus {
    OPEN,
    PROCESS,
    CLOSE
}