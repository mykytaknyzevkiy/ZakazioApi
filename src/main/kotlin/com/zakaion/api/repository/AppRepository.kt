package com.zakaion.api.repository

import com.zakaion.api.dao.AppDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.AppEntity
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class AppRepository(private val userDao: UserDao, private val appDao: AppDao) {

    fun create(partnerID: String, secretKey: String, name: String): AppEntity {
        val data = AppEntity(
                name = name,
                partner = userDao.findById(partnerID).get(),
                privateKey = secretKey
        )

        return appDao.save(data)
    }

    fun get(id: String): AppEntity = appDao.findById(id).orElseGet {
        throw ResponseStatusException(
                HttpStatus.NOT_FOUND, "No app found"
        )
    }

    fun list(partnerID: String) = appDao.findAll().filter { it.partner.id == partnerID }

    fun listAll() = appDao.findAll().toList()

    fun update(appID: String, name: String): AppEntity {
        val app = get(appID)
        app.apply {
            this.name = name
        }
        return appDao.save(app)
    }

    fun delete(appEntity: AppEntity) {
        appDao.delete(appEntity)
    }

}