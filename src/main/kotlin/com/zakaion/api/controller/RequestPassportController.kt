package com.zakaion.api.controller

import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.PassportDao
import com.zakaion.api.dao.RequestPassportDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.PassportEntity
import com.zakaion.api.entity.RequestPassportEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.PassportModel
import com.zakaion.api.roleControllers.CanSuperAdmin_Admin_Editor
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["passport/request"])
class RequestPassportController(
        private val userController: UserController,
        private val userDao: UserDao,
        private val requestPassportDao: RequestPassportDao,
        private val passportDao: PassportDao
) : BaseController() {

    @GetMapping("/list")
    @CanSuperAdmin_Admin_Editor
    fun list(pageable: Pageable) : DataResponse<Page<RequestPassportEntity>> {
        return DataResponse.ok(
                requestPassportDao.findAll(pageable)
        )
    }

    @GetMapping("/{id}")
    @CanSuperAdmin_Admin_Editor
    fun get(@PathVariable("id") id: Long) : DataResponse<RequestPassportEntity> {
        return DataResponse.ok(
                requestPassportDao.findById(id).orElseGet {
                    throw NotFound()
                }
        )
    }

    @PostMapping("/")
    fun add(@RequestBody passportModel: PassportModel) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        if (passportModel.date_begin.isEmpty ||
                passportModel.files.isEmpty() ||
                passportModel.number.isEmpty ||
                passportModel.serial.isEmpty)
            throw BadParams()

        requestPassportDao
                .save(
                        RequestPassportEntity(
                                user = myUser,
                                number = passportModel.number,
                                serial = passportModel.serial,
                                files = passportModel.files,
                                date_begin = passportModel.date_begin
                        )
                )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/accept")
    @CanSuperAdmin_Admin_Editor
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
                        files = requestPassport.files
                )
        )

        requestPassportDao.delete(requestPassport)

        userDao.save(
                requestPassport.user.apply {
                    isPassportActive = true
                }
        )

        //TODO(Send notification)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/refuse")
    @CanSuperAdmin_Admin_Editor
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