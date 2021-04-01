package com.zakazio.sms.dao

import org.hibernate.annotations.CreationTimestamp
import org.springframework.data.jpa.domain.support.AuditingEntityListener
import java.util.*
import javax.persistence.*

@EntityListeners(AuditingEntityListener::class)
@MappedSuperclass
abstract class AbstractEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    open val id: Long = 0L

    @CreationTimestamp
    @Column(name = "creation_date_time", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    open val creationDateTime: Date = Date()
}