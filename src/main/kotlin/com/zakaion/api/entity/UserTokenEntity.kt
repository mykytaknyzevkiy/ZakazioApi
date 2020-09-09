package com.zakaion.api.entity

import org.hibernate.annotations.GenericGenerator
import java.text.SimpleDateFormat
import java.util.*
import javax.persistence.*

@Entity(name = "user_token")
data class UserTokenEntity(
        @Id
        @GeneratedValue(generator="system-uuid")
        @GenericGenerator(name="system-uuid", strategy = "uuid")
        val toke: String = "",
        @Column(name = "expired_date")
        val expiredDate: Long = System.currentTimeMillis(),
        @Column(name = "user_id")
        val userID: String
) {

    fun expiredDataStr(): String {
        val sdf = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", Locale.getDefault())
        return sdf.format(Date(expiredDate))
    }

}