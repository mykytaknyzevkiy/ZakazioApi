package com.zakaion.api.controller.user

import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.entity.user._Can_SuperAdmin_Admin_Editor
import com.zakaion.api.entity.user._Can_SuperAdmin_Admin_Editor_Partner
import com.zakaion.api.exception.AlreadyTaken
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.ClientInfo
import com.zakaion.api.model.DataResponse
import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.service.EmailService
import com.zakaion.api.service.SmsService
import com.zakaion.api.service.StorageService
import com.zakaion.api.unit.ImportExcellService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["client"])
class ClientController (private val userDao: UserDao,
                        private val authTokenService: AuthTokenService,
                        private val userController: UserController,
                        private val smsService: SmsService,
                        private val userFactory: UserFactory,
                        private val storageService: StorageService,
                        private val importExcellService: ImportExcellService,
                        private val emailService: EmailService) : RoleUserController(userDao, authTokenService, emailService, userFactory) {

    override val roleType: RoleType
        get() = RoleType.CLIENT

    @DeleteMapping("/{id}")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun delete(@PathVariable("id") id: Long): DataResponse<Nothing?> {

        val user = userDao.findById(id).orElseGet { throw NotFound() }
        if (user.role != RoleType.CLIENT) throw NotFound()

        userDao.delete(user)

        return DataResponse.ok(null)
    }

    @PostMapping("/add")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor_Partner)
    fun add(@RequestBody userEntity: UserEntity): DataResponse<UserEntity> {
        val myUser = userFactory.myUser

        if (userEntity.phoneNumber.isNullOrEmpty() || userEntity.email.isNullOrEmpty())
            throw BadParams()

        if (userDao.findAll().any { it.phoneNumber == userEntity.phoneNumber || it.email == userEntity.email }) {
            throw AlreadyTaken()
        }

        return DataResponse.ok(
                userDao.save(
                        userEntity.copy(
                                role = RoleType.CLIENT
                        ).apply {
                            if (myUser.role == RoleType.PARTNER) {
                                this.masterID = myUser.id
                            }
                        }
                )
        )
    }

    @PostMapping("/import/{filename:.+}")
    suspend fun import(@PathVariable filename: String) : DataResponse<Nothing?> = withContext(Dispatchers.IO) {
        val inputStream = storageService.loadAsFile(filename).inputStream()

        importExcellService.processUser(inputStream, RoleType.CLIENT)

        return@withContext DataResponse.ok(null)
    }
}