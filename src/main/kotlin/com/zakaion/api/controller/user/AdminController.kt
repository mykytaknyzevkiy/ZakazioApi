package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.roleControllers.CanAddAdmins
import com.zakaion.api.roleControllers.CanViewAdmins
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["admin"])
class AdminController (private val userDao: UserDao) : BaseController() {

    @GetMapping("/list")
    @CanViewAdmins
    fun list() : DataResponse<List<UserEntity>> {
        return DataResponse.ok(
                userDao.findAll().filter { it.role == RoleType.ADMIN }
        )
    }

    @PostMapping("/add")
    @CanAddAdmins
    fun add(@RequestBody userEntity: UserEntity) : DataResponse<UserEntity> {
        val copy = userEntity.copy(role = RoleType.ADMIN)

        return DataResponse.ok(
                userDao.save(copy)
        )
    }

    @DeleteMapping("/{id}")
    @CanAddAdmins
    fun delete(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        userDao.delete(user)

        return DataResponse.ok(
                null
        )
    }

}
