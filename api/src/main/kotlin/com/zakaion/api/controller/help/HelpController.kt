package com.zakaion.api.controller.help

import com.zakaion.api.dao.HelpMessageDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.help.HelpMessageEntity
import com.zakaion.api.entity.help.HelpStatus
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.AddHelpRequestModel
import com.zakaion.api.model.DataResponse
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["help"])
class HelpController(private val helpMessageDao: HelpMessageDao,
                     private val userFactory: UserFactory,
                     private val userDao: UserDao) {

    @PostMapping("/add")
    fun add(@RequestBody addHelpRequestModel: AddHelpRequestModel): DataResponse<Nothing?> {

        if (userFactory.myUser.masterID != null) {
            val master = userDao.findById(userFactory.myUser.masterID!!).orElseGet {
                throw NotFound()
            }

            helpMessageDao.save(
                HelpMessageEntity(
                    user = userFactory.myUser,
                    message = addHelpRequestModel.message,
                    files = addHelpRequestModel.files,
                    worker = master
                )
            )

            return DataResponse.ok(null)
        }

        helpMessageDao.save(
            HelpMessageEntity(
                user = userFactory.myUser,
                message = addHelpRequestModel.message,
                files = addHelpRequestModel.files
            )
        )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/process")
    fun process(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val helpMessageEntity = helpMessageDao.findById(id).orElseGet {
            throw NotFound()
        }

        helpMessageDao.save(
            helpMessageEntity.copy(status = HelpStatus.PROCESS)
        )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/close")
    fun close(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val helpMessageEntity = helpMessageDao.findById(id).orElseGet {
            throw NotFound()
        }

        helpMessageDao.save(
            helpMessageEntity.copy(status = HelpStatus.CLOSE)
        )

        return DataResponse.ok(null)
    }

    @GetMapping("/list")
    fun list(pageable: Pageable): DataResponse<Page<HelpMessageEntity>> {
        return DataResponse.ok(
            if (userFactory.myUser.role == RoleType.PARTNER)
                helpMessageDao.findAllMaster(pageable, userFactory.myUser.id)
            else
                helpMessageDao.findAllNoMaster(pageable)
        )
    }

    @GetMapping("/{id}")
    fun info(@PathVariable("id") id: Long): DataResponse<HelpMessageEntity> {
        val helpMessageEntity = helpMessageDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(helpMessageEntity)
    }
}