package com.zakaion.api.controller.category

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.CategoryDao
import com.zakaion.api.entity.order.CategoryEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.EditCategoryModel
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor
import com.zakaion.api.service.StorageService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@CrossOrigin
@RequestMapping(value = ["category"])
class CategoryController(private val categoryDao: CategoryDao,
                         private val storageService: StorageService) : BaseController() {

    @GetMapping("/list")
    fun list(pageable: Pageable) : DataResponse<Page<CategoryEntity>> {
        val data = categoryDao.findAll(pageable)
        return DataResponse.ok(
                data
        )
    }

    @GetMapping("/list/active")
    fun listActive(pageable: Pageable) : DataResponse<Page<CategoryEntity>> {
        val data = categoryDao.findAllActive(pageable)
        return DataResponse.ok(
                data
        )
    }

    @PostMapping("/add")
    @CanSuperAdmin_Admin_Editor
    fun add(@RequestBody editCategoryModel: EditCategoryModel) : DataResponse<CategoryEntity> {
        if (editCategoryModel.image == null || editCategoryModel.name.isEmpty()) throw BadParams()
        val image = storageService.store(Base64.getDecoder().decode(editCategoryModel.image), "jpg")

        return DataResponse.ok(
                categoryDao.save(
                        CategoryEntity(
                                name = editCategoryModel.name,
                                isActive = editCategoryModel.isActive,
                                imageUrl = image
                        )
                )
        )
    }

    @PutMapping("/{id}/update")
    @CanSuperAdmin_Admin_Editor
    fun update(@PathVariable("id") id: Long,
               @RequestBody editCategoryModel: EditCategoryModel) : DataResponse<CategoryEntity> {

        val category = categoryDao.findById(id).orElseGet { throw NotFound() }

        if (editCategoryModel.name.isEmpty()) throw BadParams()

        category.apply {
            this.name = editCategoryModel.name
            this.isActive = editCategoryModel.isActive
            if (editCategoryModel.image != null) {
                if (this.imageUrl != null)
                    storageService.delete(this.imageUrl!!)

                this.imageUrl = storageService.store(Base64.getDecoder().decode(editCategoryModel.image), "jpg")
            }
        }

        return DataResponse.ok(
                categoryDao.save(
                        category
                )
        )
    }

}