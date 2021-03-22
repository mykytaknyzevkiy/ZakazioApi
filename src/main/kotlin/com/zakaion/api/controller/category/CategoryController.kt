package com.zakaion.api.controller.category

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.CategoryDao
import com.zakaion.api.dao.ChildCategoryDao
import com.zakaion.api.entity.order.category.CategoryEntity
import com.zakaion.api.entity.order.category.ChildCategoryEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.EditCategoryModel
import com.zakaion.api.model.GlobalCategory
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor
import com.zakaion.api.service.StorageService
import kotlinx.coroutines.*
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

@RestController
@CrossOrigin
@RequestMapping(value = ["category"])
class CategoryController(private val categoryDao: CategoryDao,
                         private val storageService: StorageService,
                         private val childCategoryDao: ChildCategoryDao) : BaseController() {

    @GetMapping("/list")
    fun list(pageable: Pageable) : DataResponse<Page<CategoryEntity>> {
        val data = categoryDao.findAll(pageable)
        return DataResponse.ok(
                data
        )
    }

    @GetMapping("/list/active/search")
    fun listActive(pageable: Pageable, @RequestParam("query") query: String) : DataResponse<Page<CategoryEntity>> {
        val data = categoryDao.searchAllActive(pageable, query)
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

    @GetMapping("/{parent_id}/list")
    fun listChild(pageable: Pageable,
                   @RequestParam("query") query: String,
                   @PathVariable("parent_id") parentID: Long) : DataResponse<Page<ChildCategoryEntity>> {

        return DataResponse.ok(
            childCategoryDao.findAll(pageable, parentID, query)
        )
    }

    @PostMapping("/{parent_id}/add")
    @CanSuperAdmin_Admin_Editor
    fun addChild(@PathVariable("parent_id") parentID: Long,
            @RequestBody editCategoryModel: EditCategoryModel) : DataResponse<ChildCategoryEntity> {
        if (editCategoryModel.name.isEmpty()) throw BadParams()

        val child = ChildCategoryEntity(
            name = editCategoryModel.name,
            parent = categoryDao.findById(parentID).orElseGet {
                throw NotFound()
            }
        )

        return DataResponse.ok(
            childCategoryDao.save(
                child
            )
        )
    }

    @PutMapping("/{parent_id}/{id}/update")
    @CanSuperAdmin_Admin_Editor
    fun updateChild(@PathVariable("parent_id") parentID: Long,
                    @PathVariable("id") childID: Long,
                    @RequestBody editCategoryModel: EditCategoryModel) : DataResponse<ChildCategoryEntity> {
        if (editCategoryModel.name.isEmpty()) throw BadParams()

        val child = childCategoryDao.findById(childID).orElseGet {
            throw BadParams()
        }

        return DataResponse.ok(
            childCategoryDao.save(
                child.copy(name = editCategoryModel.name)
            )
        )
    }

    @GetMapping("/global/search")
    suspend fun globalSearch(@RequestParam("query") query: String): DataResponse<List<GlobalCategory>> = withContext(Dispatchers.IO) {
        val maps = HashMap<CategoryEntity, ArrayList<ChildCategoryEntity>>()

        val parentListQuery = async(Dispatchers.IO) { categoryDao.searchAllActive(query) }
        val childListQuery = async(Dispatchers.IO) { childCategoryDao.findAll(query) }

        parentListQuery.await().forEach {
            maps[it] = arrayListOf()
        }

        childListQuery.await().forEach {
            if (!maps.containsKey(it.parent)) {
                maps[it.parent] = arrayListOf()
            }
            maps[it.parent]?.add(it)
        }

        maps.keys.forEach {
            if (maps[it]!!.isEmpty())
                maps[it]!!.addAll(
                    async { childCategoryDao.findAll(it.id, "") }.await()
                )
        }

        val data = ArrayList<GlobalCategory>()

        maps.forEach { (parent, childList) ->
            data.add(GlobalCategory(
                parent, childList
            ))
        }

        return@withContext DataResponse.ok(
            data = data
        )
    }

}