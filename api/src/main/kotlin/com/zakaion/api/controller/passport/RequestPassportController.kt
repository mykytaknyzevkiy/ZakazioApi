package com.zakaion.api.controller.passport

import com.zakaion.api.controller.BaseController
import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.dao.RequestPassportDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.executor.PassportEntity
import com.zakaion.api.entity.executor.RequestPassportEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user._Can_SuperAdmin_Admin_Editor
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.PassportModel
import com.zakaion.api.service.StorageService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["passport/request"])
class RequestPassportController(
        private val userFactory: UserFactory,
        private val userController: UserController,
        private val userDao: UserDao,
        private val requestPassportDao: RequestPassportDao,
        private val passportDao: PassportDao,
        private val storageService: StorageService
) : BaseController() {

    @GetMapping("/list")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun list(pageable: Pageable) : DataResponse<Page<RequestPassportEntity>> {
        val data = requestPassportDao.findAll(pageable)

        data.removeAll {
            it.user.id ==  userFactory.myUser.id ||
                    (it.user.role == RoleType.ADMIN && userFactory.myUser.role == RoleType.EDITOR)
        }

        return DataResponse.ok(
                data
        )
    }

    @GetMapping("/{id}")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun get(@PathVariable("id") id: Long) : DataResponse<RequestPassportEntity> {
        return DataResponse.ok(
                requestPassportDao.findById(id).orElseGet {
                    throw NotFound()
                }
        )
    }

    @PostMapping("/add")
    fun add(@RequestBody passportModel: PassportModel) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        if (passportModel.date_begin.isEmpty() ||
                passportModel.files.isEmpty() ||
                passportModel.number.isEmpty() ||
                passportModel.serial.isEmpty() ||
                passportModel.taxID.isEmpty())
            throw BadParams()


        if (passportDao.findAll().any { (it.number == passportModel.number && it.serial == passportModel.serial) || it.taxID == passportModel.taxID})
            throw BadParams()

        if (requestPassportDao.findAll().any { (it.number == passportModel.number && it.serial == passportModel.serial) || it.taxID == passportModel.taxID})
            throw BadParams()

        requestPassportDao
                .save(
                        RequestPassportEntity(
                                user = myUser,
                                number = passportModel.number,
                                serial = passportModel.serial,
                                files = passportModel.files.map {
                                    storageService.store(Base64.getDecoder().decode(it), "jpg")
                                },
                                date_begin = passportModel.date_begin,
                                taxID = passportModel.taxID
                        )
                )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/accept")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun accept(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val requestPassport = requestPassportDao.findById(id).orElseGet {
            throw NotFound()
        }

        passportDao.save(
                PassportEntity(
                        user = requestPassport.user,
                        serial = requestPassport.serial,
                        number = requestPassport.number,
                        date_begin = requestPassport.date_begin,
                        files = requestPassport.files.map {
                            it
                        },
                        taxID = requestPassport.taxID
                )
        )

        val user = requestPassport.user

        requestPassportDao.delete(requestPassport)

        userDao.save(
                user.apply {
                    isPassportActive = true
                }
        )

        //TODO(Send notification)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/refuse")
    @PreAuthorize(_Can_SuperAdmin_Admin_Editor)
    fun refuse(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val requestPassport = requestPassportDao.findById(id).orElseGet {
            throw NotFound()
        }

        requestPassportDao.delete(requestPassport)

        userDao.save(
                requestPassport.user.apply {
                    isPassportActive = false
                }
        )

        //TODO(Send notification)

        return DataResponse.ok(null)
    }

}