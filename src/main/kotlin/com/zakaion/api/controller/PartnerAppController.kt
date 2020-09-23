package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.controller.request.AppRequestBody
import com.zakaion.api.entity.AppEntity
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.repository.AppRepository
import com.zakaion.api.repository.UserRepository
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/partner/app"])
class PartnerAppController(
        private val userController: UserController,
        private val partnerController: PartnerController,
        private val userRepository: UserRepository,
        private val appRepository: AppRepository) {

    @PostMapping("/create")
    fun create(@RequestHeader(name = Config.tokenParameterName) token: String,
               @RequestBody appRequestBody: AppRequestBody): DataResponse<AppEntity> {

        val myUser = partnerController.user(token).data as UserEntity

        return DataResponse(
                data = appRepository.create(myUser.id, appRequestBody.name)
        )
    }

    @GetMapping("/{id}")
    fun get(@RequestHeader(name = Config.tokenParameterName) token: String,
            @PathVariable("id") appID: String): DataResponse<AppEntity> {

        val myUser = userController.user(token).data as UserEntity

        val app = appRepository.get(appID)

        if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor || app.partner.id == myUser.id) {
            return DataResponse(
                    data = app
            )
        } else {
            throw ResponseStatusException(
                    HttpStatus.NOT_ACCEPTABLE, "No permission"
            )
        }
    }

    @PutMapping("/{id}")
    fun update(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable("id") appID: String,
               @RequestBody appRequestBody: AppRequestBody): DataResponse<AppEntity> {

        val myUser = userController.user(token).data as UserEntity

        val app = appRepository.get(appID)

        if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor || app.partner.id == myUser.id) {
            return DataResponse(
                    data = appRepository.update(appID, appRequestBody.name)
            )
        } else {
            throw ResponseStatusException(
                    HttpStatus.NOT_ACCEPTABLE, "No permission"
            )
        }
    }

    @DeleteMapping("/{id}")
    fun delete(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable("id") appID: String): DataResponse<Any?> {

        val myUser = userController.user(token).data as UserEntity

        val app = appRepository.get(appID)

        if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor || app.partner.id == myUser.id) {
            appRepository.delete(app)
            return DataResponse(
                    data = null
            )
        } else {
            throw ResponseStatusException(
                    HttpStatus.NOT_ACCEPTABLE, "No permission"
            )
        }
    }

    @GetMapping("/list")
    fun list(@RequestHeader(name = Config.tokenParameterName) token: String,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10):
            DataResponse<PageResponse<AppEntity>> {
        val myUser = userController.user(token).data as UserEntity

        return if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor) {
            val list = appRepository.listAll()
            DataResponse(
                    data = UnitN.makePaginationResponse(list, pageNo = page, pageSize = size)
            )
        } else if (myUser.isPartner) {
            val list = appRepository.list(myUser.id)
            DataResponse(
                    data = UnitN.makePaginationResponse(list, pageNo = page, pageSize = size)
            )
        } else {
            throw ResponseStatusException(
                    HttpStatus.NOT_FOUND, "user is not partner"
            )
        }
    }

}