package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.PartnerInfo
import com.zakaion.api.roleControllers.CanSuperAdmin
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["admin"])
class AdminController (private val userDao: UserDao,
                       private val userFactory: UserFactory) : BaseController() {

    @GetMapping("/list")
    @CanSuperAdmin_Admin
    fun list(pageable: Pageable, @RequestParam("search", required = false, defaultValue = "") search: String? = null) : DataResponse<Page<PartnerInfo>> {

        val data = (
                if (search.isNullOrEmpty()) userDao.findByRole(RoleType.ADMIN.ordinal, pageable)
                else userDao.findByRole(RoleType.ADMIN.ordinal, search, pageable)
                ).map {user->
                    userFactory.create(user) as PartnerInfo
                }

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
