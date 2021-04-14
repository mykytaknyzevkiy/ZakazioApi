package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserStatus
import com.zakaion.api.exception.AlreadyTaken
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["editor"])
class EditorController(private val userDao: UserDao) : BaseController() {

    @PostMapping("/add")
    @CanSuperAdmin_Admin
    fun add(@RequestBody userEntity: UserEntity) : DataResponse<UserEntity> {
        val copy = userEntity.copy(role = RoleType.EDITOR)

        if (userDao.findAll().any { it.phoneNumber == copy.phoneNumber || it.email == copy.email })
            throw AlreadyTaken()

        return DataResponse.ok(
                userDao.save(copy)
        )
    }

    @DeleteMapping("/{id}")
    @CanSuperAdmin_Admin
    fun delete(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (user.role != RoleType.EDITOR)
            throw NotFound()

        userDao.delete(user)

        return DataResponse.ok(
                null
        )
    }

    @GetMapping("/{id}")
    @CanSuperAdmin_Admin
    fun get(@PathVariable("id") id: Long) : DataResponse<UserEntity> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (user.role != RoleType.EDITOR)
            throw NotFound()

        return DataResponse.ok(
                user
        )
    }

}