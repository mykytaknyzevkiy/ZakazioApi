package com.zakaion.api.service

import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserStatus
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import org.springframework.stereotype.Service
import java.security.Key
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.*

const val JWT_SECRET = "JuliyaILoveULoveLoveLoveLoveLoveNikita"

@Service
class AuthTokenService (private val userDao: UserDao) {

    fun generateToken(user: UserEntity): String {
        val expirationTime = Instant.now().plus(100, ChronoUnit.HOURS)
        val expirationDate: Date = Date.from(expirationTime)

        val key: Key = Keys.hmacShaKeyFor(JWT_SECRET.toByteArray())

        return Jwts.builder()
                .claim("id", user.id)
                .claim("fName", user.firstName)
                .claim("lName", user.lastName)
                .claim("mName", user.middleName)
                .setExpiration(expirationDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact()
    }

    fun parseToken(token: String): UserEntity? {
        val secretBytes = JWT_SECRET.toByteArray()

        return try {
            val jwsClaims = Jwts.parserBuilder()
                    .setSigningKey(secretBytes)
                    .build()
                    .parseClaimsJws(token)

            val userId = jwsClaims.body
                    .get("id", java.lang.Integer::class.java)

            val user = userDao.findById(userId.toLong()).orElseGet { null } ?: return null

            user
        } catch (e: Exception) {
            null
        }
    }

    fun generatePhoneToken(phoneNumber: String, smsCode: String): String {
        val expirationTime = Instant.now().plus(1, ChronoUnit.HOURS)
        val expirationDate: Date = Date.from(expirationTime)

        val key: Key = Keys.hmacShaKeyFor(JWT_SECRET.toByteArray())

        return Jwts.builder()
                .claim("phone_number", phoneNumber)
                .claim("sms_code", smsCode)
                .setExpiration(expirationDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact()
    }

    fun parsePhoneToken(token: String): Pair<String, String>? {
        val secretBytes = JWT_SECRET.toByteArray()

        try {
            val jwsClaims = Jwts.parserBuilder()
                    .setSigningKey(secretBytes)
                    .build()
                    .parseClaimsJws(token)

            val phoneNumber = jwsClaims.body
                    .get("phone_number", String::class.java)

            val smsCode = jwsClaims.body
                    .get("sms_code", String::class.java)

            return Pair(phoneNumber, smsCode)
        } catch (e: Exception) {
            return null
        }
    }

    fun generateFeedbackToken(orderID: Long, userID: Long) : String {
        val key: Key = Keys.hmacShaKeyFor(JWT_SECRET.toByteArray())

        return Jwts.builder()
                .claim("orderID", orderID)
                .claim("userID", userID)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact()
    }

    fun parseFeedbackToken(token: String) : Pair<Long, Long> {
        val secretBytes = JWT_SECRET.toByteArray()

        val jwsClaims = Jwts.parserBuilder()
                .setSigningKey(secretBytes)
                .build()
                .parseClaimsJws(token)

        return Pair(
                jwsClaims.body
                        .get("orderID", Long::class.java),
                jwsClaims.body
                        .get("userID", Long::class.java)
        )
    }

    fun generateAuthCode() = "1234"

}