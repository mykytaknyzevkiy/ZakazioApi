package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.roleControllers.CanSuperAdmin
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["admin"])
class AdminController (private val userDao: UserDao) : BaseController() {

    @GetMapping("/list")
    @CanSuperAdmin_Admin
    fun list(pageable: Pageable) : DataResponse<Page<UserEntity>> {
        val data = userDao.findByRole(RoleType.ADMIN.ordinal, pageable)
        return DataResponse.ok(
                data
        )
    }

    @PostMapping("/add")
    @CanSuperAdmin
    fun add(@RequestBody userEntity: UserEntity) : DataResponse<UserEntity> {
        val copy = userEntity.copy(role = RoleType.ADMIN)

        return DataResponse.ok(
                userDao.save(copy)
        )
    }

    @DeleteMapping("/{id}")
    @CanSuperAdmin
    fun delete(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (user.role != RoleType.ADMIN)
            throw NotFound()

        userDao.delete(user)

        return DataResponse.ok(
                null
        )
    }

    @CanSuperAdmin_Admin
    @GetMapping("/{id}")
    fun get(@PathVariable("id") id: Long) : DataResponse<UserEntity> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (user.role != RoleType.ADMIN)
            throw NotFound()

        return DataResponse.ok(
                user
        )
    }

}
