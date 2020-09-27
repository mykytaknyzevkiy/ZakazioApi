package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.UnitN
import com.zakaion.api.controller.app.PartnerAppController
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.controller.request.SetOrderExecutorRequest
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.entity.OrderEntity
import com.zakaion.api.entity.OrderStatus
import com.zakaion.api.entity.UserEntity
import org.springframework.format.annotation.DateTimeFormat
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
             @RequestParam(name = "app_id", required = false) appID: String? = null,
             @RequestParam(name = "status", required = false) status: String? = null,
             @RequestParam(name = "start_date", required = false) @DateTimeFormat(pattern = "dd.MM.yyyy") startDate: Date? = null,
             @RequestParam(name = "end_date", required = false) @DateTimeFormat(pattern = "dd.MM.yyyy") endDate: Date? = null
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

    @GetMapping("/{id}")
    fun get(@RequestHeader(name = Config.tokenParameterName) token: String,
            @PathVariable(name = "id") id: String): DataResponse<OrderEntity> {
        val myUser = userController.user(token).data as UserEntity

        val mOrder = orderDao.findById(id).orElseGet {
            throw ResponseStatusException(
                    HttpStatus.NOT_FOUND, "Order not found"
            )
        }

        if (myUser.isEditor
                || myUser.isAdmin
                || myUser.isSuperAdmin
                || mOrder.app.partner.id == myUser.id
                || mOrder.executor?.id == myUser.id
                || mOrder.executorAgent?.id == mOrder.id
                || mOrder.client.id == mOrder.id) {
            return DataResponse(
                    data = orderDao.save(mOrder)
            )
        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}")
    fun update(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable(name = "id") id: String,
               @RequestBody orderEntity: OrderEntity): DataResponse<OrderEntity> {
        val myUser = userController.user(token).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        if (mOrder.status == OrderStatus.DONE.data || mOrder.status == OrderStatus.CANCEL.data || mOrder.status == OrderStatus.EXECUTED.data)
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "U cannot update order more"
            )

        if (myUser.isEditor || myUser.isAdmin || myUser.isSuperAdmin || mOrder.app.partner.id == myUser.id) {
            mOrder.apply {
                this.content = orderEntity.content
                this.totalPrice = orderEntity.totalPrice
            }

            return DataResponse(
                    data = orderDao.save(mOrder)
            )
        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}/set/executor")
    fun setExecutor(@RequestHeader(name = Config.tokenParameterName) token: String,
                    @PathVariable(name = "id") id: String,
                    @RequestBody setOrderExecutorRequest: SetOrderExecutorRequest): DataResponse<OrderEntity> {

        val myUser = userController.user(token).data as UserEntity

        val executor = userController.user(token, setOrderExecutorRequest.id).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.app.partner.id == myUser.id) {

            if (mOrder.status == OrderStatus.DONE.data || mOrder.status == OrderStatus.EXECUTED.data || mOrder.status == OrderStatus.CANCEL.data)
                throw ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "No permission"
                )

            if ((mOrder.executor != null || mOrder.executorAgent != null) && mOrder.executorAgent?.id != myUser.id)
                cancelExecutor(token, id)

            when {
                mOrder.executorAgent?.id != myUser.id -> {
                    when {
                        executor.isEditor -> mOrder.executor = executor
                        executor.isAgent -> mOrder.executorAgent = executor
                        else -> throw ResponseStatusException(
                                HttpStatus.BAD_REQUEST, "User is not executor"
                        )
                    }
                }
                executor.isExecutor-> {
                    mOrder.executor = executor
                }
                else -> {
                    throw ResponseStatusException(
                            HttpStatus.BAD_REQUEST, "User is not executor"
                    )
                }
            }

            return DataResponse(
                    data = orderDao.save(mOrder)
            )

        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}/cancel/executor")
    fun cancelExecutor(@RequestHeader(name = Config.tokenParameterName) token: String,
                       @PathVariable(name = "id") id: String): DataResponse<OrderEntity> {

        val myUser = userController.user(token).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        val executorID = when {
            mOrder.executor != null -> mOrder.executor!!.id
            mOrder.executorAgent != null -> mOrder.executorAgent!!.id
            else -> throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "No executor found"
            )
        }

        val executor = userController.user(token, executorID)

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.app.partner.id == myUser.id) {

            if (mOrder.status == OrderStatus.PROCESS.data || mOrder.status == OrderStatus.EXECUTING.data) {
                mOrder.apply {
                    this.executor = null
                    this.executorAgent == null
                }

                return DataResponse(
                        data = orderDao.save(mOrder)
                )
            }
            else {
                throw ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "U cannot cancel this order"
                )
            }

        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}/status/set/done")
    fun done(@RequestHeader(name = Config.tokenParameterName) token: String,
                  @PathVariable(name = "id") id: String): DataResponse<OrderEntity> {
        val myUser = userController.user(token).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.app.partner.id == myUser.id) {

            if (mOrder.status != OrderStatus.EXECUTED.data) {
                throw ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "Order is not executed yet"
                )
            }

            mOrder.status = OrderStatus.DONE.data

            return DataResponse(
                    data = orderDao.save(mOrder)
            )

        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}/status/set/cancel")
    fun cancel(@RequestHeader(name = Config.tokenParameterName) token: String,
                  @PathVariable(name = "id") id: String): DataResponse<OrderEntity> {
        val myUser = userController.user(token).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.app.partner.id == myUser.id) {

            if (mOrder.status == OrderStatus.PROCESS.data || mOrder.status == OrderStatus.EXECUTING.data) {
                mOrder.status = OrderStatus.CANCEL.data

                return DataResponse(
                        data = orderDao.save(mOrder)
                )
            }
            else {
                throw ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "U cannot cancel this order"
                )
            }

        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}/status/set/executed")
    fun executed(@RequestHeader(name = Config.tokenParameterName) token: String,
                 @PathVariable(name = "id") id: String): DataResponse<OrderEntity> {
        val myUser = userController.user(token).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        if (mOrder.executor?.id == myUser.id || mOrder.executorAgent?.id == myUser.id) {

            if (mOrder.status != OrderStatus.EXECUTING.data) {
                throw ResponseStatusException(
                        HttpStatus.BAD_REQUEST, "Order is not executed yet"
                )
            }

            mOrder.status = OrderStatus.EXECUTED.data

            return DataResponse(
                    data = orderDao.save(mOrder)
            )

        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }

    @PutMapping("/{id}/status/set/executing")
    fun executing(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable(name = "id") id: String): DataResponse<OrderEntity> {
        val myUser = userController.user(token).data as UserEntity

        val mOrder = get(token, id).data as OrderEntity

        if (mOrder.executor?.id == myUser.id || mOrder.executorAgent?.id == myUser.id) {

            mOrder.status = OrderStatus.EXECUTING.data

            return DataResponse(
                    data = orderDao.save(mOrder)
            )

        } else {
            throw ResponseStatusException(
                    HttpStatus.UNAUTHORIZED, "No permission"
            )
        }
    }


}