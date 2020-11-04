package com.zakaion.api.controller

import com.zakaion.api.dao.CategoryDao
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.EditCategoryModel
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["category"])
class CategoryController(private val categoryDao: CategoryDao) : BaseController() {

    @GetMapping("/list")
    fun list(pageable: Pageable) : DataResponse<Page<CategoryEntity>> {
        val data = categoryDao.findAll(pageable)
        return DataResponse.ok(
                data
        )
    }

    @PostMapping("/add")
    @CanSuperAdmin_Admin_Editor
    fun add(@RequestBody editCategoryModel: EditCategoryModel) : DataResponse<CategoryEntity> {
        if (editCategoryModel.image == null) throw BadParams()


    }

}