package com.zakaion.api.repository

import com.zakaion.api.dao.UserDao
import com.zakaion.api.dao.UserTokenDao
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.entity.UserTokenEntity
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.PageRequest
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.util.*

@Service
class UserRepository(private val userDao: UserDao, private val userTokenDao: UserTokenDao) {

    fun save(userEntity: UserEntity): String {
        return userDao.save(userEntity).id
    }

    fun update(userEntity: UserEntity): UserEntity {
        return userDao.save(userEntity)
    }

    fun user(id: String): Optional<UserEntity> {
        return userDao.findById(id)
    }

    fun user(email: String, password: String): Optional<UserEntity> {
        val user = userDao.findAll().find { it.email == email && it.password == password }

        return Optional.ofNullable(user)
    }

    fun userByEmail(email: String): Optional<UserEntity> {
        val user = userDao.findAll().find { it.email == email}

        return Optional.ofNullable(user)
    }

    fun users() = userDao.findAll().toList()

    fun users(pageNo: Int, pageSize: Int): List<UserEntity> {
        return userDao.findAll(PageRequest.of(pageNo, pageSize)).toList()
    }

    fun createToken(userID: String): UserTokenEntity {
        return userTokenDao.save(UserTokenEntity(
                userID = userID,
                expiredDate = System.currentTimeMillis() + (30 * 60 * 60 * 1000)
        ))
    }

    fun userByToken(token: String): UserEntity {
        val userToken = userTokenDao.findById(token).orElseGet {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "wrong token"
            )
        }

        return userDao.findById(userToken.userID).orElseGet {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "user not found"
            )
        }
    }

    fun validateUserToken(token: String) {
        val userToken = userTokenDao.findById(token).orElseGet {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "wrong token"
            )
        }

        if (System.currentTimeMillis() > userToken.expiredDate) {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "token expired"
            )
        }
    }

}