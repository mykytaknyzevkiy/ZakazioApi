package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.repository.CategoryRepository
import com.zakaion.api.repository.StorageService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.server.ResponseStatusException

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
    fun create(
            @RequestHeader(name = Config.tokenParameterName) token: String,
            @RequestBody categoryEntity: CategoryEntity,
            @RequestParam("image") file: MultipartFile)
            : DataResponse<CategoryEntity> {

        val myUser = userController.user(token).data as UserEntity

        if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor) {
            categoryEntity.apply {
                image = filesController.save(file)
            }

            return DataResponse(
                    success = true,
                    data = categoryRepository.save(categoryEntity)
            )
        }
        else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "Allow dined"
            )
        }
    }

    @PutMapping("/update")
    fun update(
            @RequestHeader(name = Config.tokenParameterName) token: String,
            @RequestBody categoryEntity: CategoryEntity,
            @RequestParam("image") file: MultipartFile)
            : DataResponse<CategoryEntity> {

        val myUser = userController.user(token).data as UserEntity

        if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor) {

            categoryEntity.apply {
                image = filesController.save(file)
            }

            return DataResponse(
                    success = true,
                    data = categoryRepository.save(categoryEntity)
            )

        }
        else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "Allow dined"
            )
        }
    }


}