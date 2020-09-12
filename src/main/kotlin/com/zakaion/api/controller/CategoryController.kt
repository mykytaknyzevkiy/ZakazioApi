package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.repository.CategoryRepository
import com.zakaion.api.repository.StorageService
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/category"])
class CategoryController(private val userController: UserController,
                         private val filesController: FilesController,
                         private val categoryRepository: CategoryRepository) {

    @GetMapping("/list")
    fun list(@RequestHeader(name = Config.tokenParameterName) token: String,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10,
             @RequestParam(name = "onlyActives", required = false, defaultValue = "false") onlyActives: Boolean = false)
            : DataResponse<PageResponse<CategoryEntity>> {
        val myUser = userController.user(token)

        val list = categoryRepository.list().filter {
            !onlyActives || (it.active)
        }

        return DataResponse(
                success = true,
                error = null,
                data = UnitN.makePaginationResponse(list, pageNo = page, pageSize = size)
        )
    }

    @PostMapping("/create")
    fun create(@RequestBody categoryEntity: CategoryEntity,
               @RequestParam("image") file: MultipartFile)
            : DataResponse<CategoryEntity> {
        categoryEntity.apply {
            image = filesController.save(file)
        }

        return DataResponse(
                success = true,
                data = categoryRepository.save(categoryEntity)
        )
    }


}