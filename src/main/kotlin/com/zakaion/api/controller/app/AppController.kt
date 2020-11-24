package com.zakaion.api.controller.app

import com.zakaion.api.controller.BaseController
import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.AppDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.AppEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.AppModel
import com.zakaion.api.model.DataResponse
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@CrossOrigin
@RequestMapping(value = ["app"])
class AppController(private val userController: UserController,
                    private val appDao: AppDao,
                    private val userDao: UserDao) : BaseController() {

    @PostMapping("/add")
    fun add(@RequestBody appModel: AppModel) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        if (appModel.name.isEmpty)
            throw BadParams()

        appDao.save(
                AppEntity(
                        name = appModel.name,
                        key = UUID.randomUUID().toString(),
                        masterID = myUser.id
                )
        )

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/update")
    fun update(@PathVariable("id") id: Long,
               @RequestBody appModel: AppModel) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        val appEntity = appDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (appEntity.masterID != myUser.id &&
                myUser.role !in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            throw NoPermittedMethod()

        if (appModel.name.isEmpty)
            throw BadParams()

        appEntity.name = appModel.name

        appDao.save(appEntity)

        return DataResponse.ok(null)
    }

    @DeleteMapping("/{id}/delete")
    fun delete(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        val appEntity = appDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (appEntity.masterID != myUser.id &&
                myUser.role !in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            throw NoPermittedMethod()

        appDao.delete(appEntity)

        return DataResponse.ok(null)
    }

    @GetMapping("/{id}")
    fun get(@PathVariable("id") id: Long) : DataResponse<AppModel> {
        val myUser = userController.get().data

        val appEntity = appDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(
                appEntity.toResponse(userDao, myUser)
        )
    }

}

fun AppEntity.toResponse(userDao: UserDao, myUser: UserEntity) : AppModel {
    return AppModel(
            id  =  this.id,
            name = this.name,
            key = this.key,
            owner =
            if (myUser.id != this.masterID && myUser.role !in arrayOf(
                            RoleType.SUPER_ADMIN,
                            RoleType.ADMIN,
                            RoleType.EDITOR))
                null
            else
                userDao.findById(this.masterID).orElseGet { null }
    )
}