package com.zakaion.api.service

import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.UserEntity
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import org.springframework.stereotype.Service
import java.security.Key
import java.time.Instant
import java.time.temporal.ChronoUnit
import java.util.*


const val JWT_SECRET = "JuliaILoveU"

@Service
class TokenService(private val userDao: UserDao) {

    fun generateToken(user: UserEntity): String {
        val expirationTime = Instant.now().plus(1, ChronoUnit.HOURS)
        val expirationDate: Date = Date.from(expirationTime)

        val key: Key = Keys.hmacShaKeyFor(JWT_SECRET.toByteArray())

        val compactTokenString: String = Jwts.builder()
                .claim("id", user.id)
                .claim("sub", user.firstName+user.lastName+user.midleName)
                .claim("superAdmin", user.isSuperAdmin)
                .claim("admin", user.isAdmin)
                .claim("editor", user.isEditor)
                .claim("partner", user.isPartner)
                .claim("executor", user.isExecutor)
                .claim("client", user.isUser)
                .setExpiration(expirationDate)
                .signWith(key, SignatureAlgorithm.HS256)
                .compact()

        return "Bearer $compactTokenString"
    }

    fun parseToken(token: String) : UserEntity? {
        val secretBytes = JWT_SECRET.toByteArray()

        val jwsClaims = Jwts.parserBuilder()
                .setSigningKey(secretBytes)
                .build()
                .parseClaimsJws(token)

        val userId = jwsClaims.body["id", String::class.java]

        return userDao.findById(userId).orElseGet { null }
    }

}