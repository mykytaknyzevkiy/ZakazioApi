package com.zakaion.api.service

import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.UserEntity
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import org.springframework.stereotype.Service
import java.security.Key
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.*


const val JWT_SECRET = "JuliyaILoveU"

@Service
class AuthTokenService (private val userDao: UserDao) {

    fun generateToken(user: UserEntity): String {
        val expirationTime = Instant.now().plus(1, ChronoUnit.YEARS)
        val expirationDate: Date = Date.from(expirationTime)

        val key: Key = Keys.hmacShaKeyFor(JWT_SECRET.toByteArray())

        val compactTokenString: String = Jwts.builder()
                .claim("id", user.id)
                .claim("fName", user.firstName)
                .claim("lName", user.lastName)
                .claim("mName", user.middleName)
                .setExpiration(expirationDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact()

        return "Bearer $compactTokenString"
    }

    fun parseToken(token: String): UserEntity? {
        val secretBytes = JWT_SECRET.toByteArray()

        return try {
            val jwsClaims = Jwts.parserBuilder()
                    .setSigningKey(secretBytes)
                    .build()
                    .parseClaimsJws(token)

            val userId = jwsClaims.body
                    .get("id", Long::class.java)

            userDao.findById(userId).orElseGet { null }
        } catch (e: Exception) {
            null
        }
    }

}