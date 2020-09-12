package com.zakaion.api.repository

import com.zakaion.api.dao.CategoryDao
import com.zakaion.api.entity.CategoryEntity
import org.springframework.stereotype.Service

@Service
class CategoryRepository(private val categoryDao: CategoryDao) {

    fun save(categoryEntity: CategoryEntity): CategoryEntity {
        return categoryDao.save(categoryEntity)
    }

    fun list() = categoryDao.findAll()

}