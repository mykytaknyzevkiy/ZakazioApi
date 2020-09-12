package com.zakaion.api.dao

import com.zakaion.api.entity.CategoryEntity
import org.springframework.data.repository.CrudRepository

interface CategoryDao : CrudRepository<CategoryEntity, String>