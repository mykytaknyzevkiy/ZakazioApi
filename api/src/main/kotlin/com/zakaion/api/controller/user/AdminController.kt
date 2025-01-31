package com.zakaion.api.controller.user

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user.UserStatus
import com.zakaion.api.entity.user._Can_SuperAdmin
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.UserFull
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.PartnerInfo
import com.zakaion.api.roleControllers.CanSuperAdmin
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.EmailService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["admin"])
class AdminController(
    private val userDao: UserDao,
    authTokenService: AuthTokenService,
    emailService: EmailService,
    userFactory: UserFactory
) : RoleUserController(userDao, authTokenService, emailService, userFactory) {

    override val roleType: RoleType
        get() = RoleType.ADMIN

    @PostMapping("/add")
    @PreAuthorize(_Can_SuperAdmin)
    fun add(@RequestBody userEntity: UserEntity) : DataResponse<Nothing?> {
        val copy = userEntity.copy(role = RoleType.ADMIN)

        if (userDao.findAll().any { it.email == copy.email || it.phoneNumber == copy.phoneNumber }) {
            throw BadParams()
        }

        userDao.save(copy)

        return DataResponse.ok(
                null
        )
    }

    @DeleteMapping("/{id}")
    @PreAuthorize(_Can_SuperAdmin)
    fun delete(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (user.role != RoleType.ADMIN)
            throw NotFound()

        userDao.delete(user)

        return DataResponse.ok(
                null
        )
    }

    @GetMapping("/{id}")
    @PreAuthorize(_Can_SuperAdmin)
    fun get(@PathVariable("id") id: Long) : DataResponse<UserEntity> {
        val user = userDao.findById(id).orElseGet { throw NotFound() }

        if (user.role != RoleType.ADMIN)
            throw NotFound()

        return DataResponse.ok(
                user
        )
    }

}
