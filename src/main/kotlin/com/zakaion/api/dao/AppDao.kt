package com.zakaion.api.dao

import com.zakaion.api.entity.AppEntity
import com.zakaion.api.entity.CategoryEntity
import org.springframework.data.repository.CrudRepository

interface AppDao : CrudRepository<AppEntity, String>