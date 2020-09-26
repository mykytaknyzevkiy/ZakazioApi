package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.UnitN
import com.zakaion.api.controller.app.PartnerAppController
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.OrderStatus
import com.zakaion.api.entity.UserEntity
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/order"])
class OrderController(
        private val userController: UserController,
        private val orderDao: OrderDao,
        private val partnerAppController: PartnerAppController
) {

    @GetMapping("/list")
    fun list(@RequestHeader(name = Config.tokenParameterName) token: String,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10,
             @RequestParam(name = "app_id", required = false, defaultValue = "null") appID: String? = null,
             @RequestParam(name = "status", required = false, defaultValue = "null") status: String? = null,
             @RequestParam(name = "start_date", required = false, defaultValue = "null") startDate: Date? = null,
             @RequestParam(name = "end_date", required = false, defaultValue = "null") endDate: Date? = null
    ): DataResponse<PageResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        var list = if (startDate != null && endDate != null) {
            orderDao.findAllByDate(startDate, endDate)
        } else {
            orderDao.findAll()
        }

        list = list.filter {
            it.client.id == myUser.id
                    || it.app.partner.id == myUser.id
                    || it.executor?.id == myUser.id
                    || it.executorAgent?.id == myUser.id
                    || (myUser.isAdmin || myUser.isEditor || myUser.isSuperAdmin)
        }

        if (appID != null) {
            partnerAppController.get(token, appID)
            list = list.filter {
                it.app.id == appID
            }
        }

        if (status != null) {
            if (!OrderStatus.values().map { it.data }.contains(status)) {
                throw ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "No status type found"
                )
            }
            list = list.filter {
                it.status == status
            }
        }

        return DataResponse(
                success = true,
                error = null,
                data = UnitN.makePaginationResponse(list, pageNo = page, pageSize = size)
        )
    }

}