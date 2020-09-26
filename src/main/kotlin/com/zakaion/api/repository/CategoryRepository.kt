package com.zakaion.api.repository

import com.zakaion.api.dao.CategoryDao
import com.zakaion.api.entity.CategoryEntity
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class CategoryRepository(private val categoryDao: CategoryDao) {

    fun save(categoryEntity: CategoryEntity): CategoryEntity {
        return categoryDao.save(categoryEntity)
    }

    fun list() = categoryDao.findAll()

    fun delete(categoryEntity: CategoryEntity) = categoryDao.delete(categoryEntity)

    fun get(id: String) = categoryDao.findById(id).orElseGet {
        throw ResponseStatusException(
                HttpStatus.NOT_FOUND, "No category found"
        )
    }

}