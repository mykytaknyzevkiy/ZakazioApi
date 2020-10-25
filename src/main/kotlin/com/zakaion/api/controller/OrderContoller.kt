package com.zakaion.api.controller

import com.zakaion.api.unit.Config
import com.zakaion.api.unit.UnitN
import com.zakaion.api.controller.app.PartnerAppController
import com.zakaion.api.controller.history.OrderHistoryController
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.controller.request.SetOrderExecutorRequest
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.*
import com.zakaion.api.model.OrderHistoryOperation
import com.zakaion.api.model.OrderResponse
import com.zakaion.api.model.convert
import com.zakaion.api.repository.CashRepository
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/order"])
class OrderController(
        private val userController: UserController,
        private val orderDao: OrderDao,
        private val partnerAppController: PartnerAppController,
        private val orderHistoryController: OrderHistoryController,
        private val cashRepository: CashRepository
) {

    fun listAll(appID: String? = null,
                status: String? = null,
                startDate: Date? = null,
                endDate: Date? = null): List<OrderEntity> {
        var list = if (startDate != null && endDate != null) {
            orderDao.findAllByDate(startDate, endDate)
        } else {
            orderDao.findAll()
        }

        if (appID != null)
            list = list.filter { it.app.id == appID}

        if (status != null)
            list = list.filter { it.status == status }

        return list.toList()
    }

    @GetMapping("/list/open")
    fun listOpen(@RequestHeader(name = Config.tokenParameterName) token: String,
                 @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
                 @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10,
                 @RequestParam(name = "app_id", required = false) appID: String? = null,
                 @RequestParam(name = "status", required = false) status: String? = null,
                 @RequestParam(name = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-mm-dd") startDate: Date? = null,
                 @RequestParam(name = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-mm-dd") endDate: Date? = null
    ): DataResponse<PageResponse<OrderResponse>> {
        val myUser = userController.user(token).data as UserEntity

        val list = listAll(appID, status, startDate, endDate).filter {
            it.executor == null
        }

        val realList = list.map {
            convert(it).apply {
                if (myUser.isExecutor && this.executor?.id != myUser.id)
                    this.client = null
                else if (myUser.isPartner && this.app.partner.id != myUser.id)
                    this.client = null
            }
        }

        return DataResponse(
                success = true,
                error = null,
                data = UnitN.makePaginationResponse(realList, pageNo = page, pageSize = size)
        )
    }

    @GetMapping("/list/mine")
    fun listMy(@RequestHeader(name = Config.tokenParameterName) token: String,
               @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
               @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10,
               @RequestParam(name = "app_id", required = false) appID: String? = null,
               @RequestParam(name = "status", required = false) status: String? = null,
               @RequestParam(name = "start_date", required = false) @DateTimeFormat(pattern = "yyyy-mm-dd") startDate: Date? = null,
               @RequestParam(name = "end_date", required = false) @DateTimeFormat(pattern = "yyyy-mm-dd") endDate: Date? = null
    ): DataResponse<PageResponse<OrderResponse>> {
        val myUser = userController.user(token).data as UserEntity

        val list = listAll(appID, status, startDate, endDate).filter {
            myUser.isSuperAdmin
                    || myUser.isAdmin
                    || myUser.isEditor
                    || (myUser.isExecutor && it.executor?.id == myUser.id)
                    || (myUser.isPartner && it.app.partner.id == myUser.id)
                    || (myUser.isUser && it.client.id == myUser.id)
        }

        val realList = list.map {
            convert(it)
        }

        return DataResponse(
                success = true,
                error = null,
                data = UnitN.makePaginationResponse(realList, pageNo = page, pageSize = size)
        )
    }

    @GetMapping("/{id}")
    fun get(@RequestHeader(name = Config.tokenParameterName) token: String,
            @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderResponse>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        val mOrder = convert(orderDao.findById(id).get()).apply {
            if (myUser.isExecutor && this.executor?.id != myUser.id)
                this.client = null
            else if (myUser.isPartner && this.app.partner.id != myUser.id)
                this.client = null
        }

        if (myUser.isSuperAdmin ||
                myUser.isAdmin ||
                myUser.isEditor)
            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        if (mOrder.executor == null && !myUser.isUser)
            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        if (myUser.isUser && mOrder.client?.id == myUser.id)
            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        if (mOrder.executor != null &&
                (mOrder.app.partner.id == myUser.id ||
                        mOrder.executor.id == myUser.id ||
                        mOrder.executor.partnerID == myUser.id))
            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "U dont have permission for this order")
    }

    @PutMapping("/{id}")
    fun update(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable(name = "id") id: Int,
               @RequestBody orderEntity: OrderEntity): ResponseEntity<DataResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.status in listOf(
                        OrderStatus.DONE.data,
                        mOrder.status == OrderStatus.CANCEL.data,
                        mOrder.status == OrderStatus.EXECUTED.data
                ))
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "U cannot update order cause order in status ${mOrder.status}")

        if (myUser.isSuperAdmin || myUser.isAdmin || myUser.isEditor || (myUser.isPartner && mOrder.app.partner.id == myUser.id)) {
            mOrder.apply {
                this.content = orderEntity.content
                this.totalPrice = orderEntity.totalPrice
            }

            mOrder = orderDao.save(mOrder)

            addHistory(OrderHistoryOperation.EDIT, myUser, mOrder, "{" +
                    "\"content\": \"${orderEntity.content}\", " +
                    "\"totalPrice\": ${orderEntity.totalPrice}" +
                    "}")

            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )
        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "U dont have permission to update this order")
    }

    @PutMapping("/{id}/set/executor")
    fun setExecutor(@RequestHeader(name = Config.tokenParameterName) token: String,
                    @PathVariable(name = "id") id: Int,
                    @RequestBody setOrderExecutorRequest: SetOrderExecutorRequest): ResponseEntity<DataResponse<OrderEntity>> {

        val myUser = userController.user(token).data as UserEntity

        val executor = userController.user(token, setOrderExecutorRequest.id).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.status in listOf(
                        OrderStatus.DONE.data,
                        mOrder.status == OrderStatus.CANCEL.data,
                        mOrder.status == OrderStatus.EXECUTED.data,
                        mOrder.status == OrderStatus.EXECUTING.data
                ))
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "U cannot update order cause order in status ${mOrder.status}")

        if (!executor.isExecutor)
            return errorResponse(HttpStatus.NOT_FOUND, "No found executor")

        if (myUser.isExecutor && mOrder.executor != null)
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You cannot be executor cause executor already exist")

        if (myUser.isPartner && mOrder.executor != null && mOrder.app.partner.id != myUser.id)
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You cannot set executor cause executor already exist")

        if (myUser.isPartner && executor.partnerID != myUser.id)
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You dont have permission for this executor")

        if (myUser.isUser)
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You dont have permission for this order")

        if (mOrder.executor != null)
            cancelExecutor(token, id)

        mOrder.executor = executor

        mOrder = orderDao.save(mOrder)

        addHistory(OrderHistoryOperation.SET_EXECUTOR, myUser, mOrder, executor.toJson())

        return ResponseEntity(
                DataResponse(
                        success = true,
                        error = null,
                        data = mOrder
                ),
                HttpStatus.OK
        )
    }

    @PutMapping("/{id}/be/executor")
    fun beExecutor(@RequestHeader(name = Config.tokenParameterName) token: String,
                   @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (!myUser.isExecutor)
            return ResponseEntity(
                    DataResponse<OrderEntity>(
                            success = false,
                            error = "You arent executor",
                            data = null
                    ), HttpStatus.METHOD_NOT_ALLOWED)

        return setExecutor(token, id, SetOrderExecutorRequest(name = null, id = myUser.id))
    }

    @PutMapping("/{id}/cancel/executor")
    fun cancelExecutor(@RequestHeader(name = Config.tokenParameterName) token: String,
                       @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderEntity>> {

        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.executor == null)
            return errorResponse(HttpStatus.NOT_FOUND, "Order not exits executor")

        val executorID = mOrder.executor!!.id

        val executor = userController.user(token, executorID)

        if (mOrder.status in listOf(
                        OrderStatus.DONE.data,
                        mOrder.status == OrderStatus.CANCEL.data,
                        mOrder.status == OrderStatus.EXECUTED.data,
                        mOrder.status == OrderStatus.EXECUTING.data
                ))
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "U cannot update order cause order in status ${mOrder.status}")

        if (myUser.isSuperAdmin ||
                myUser.isAdmin ||
                myUser.isEditor ||
                (myUser.isPartner && mOrder.app.partner.id == myUser.id) ||
                (myUser.isExecutor && myUser.id == executorID)) {

            mOrder.apply {
                this.executor = null
                this.executorAgent = null
                this.status = OrderStatus.PROCESS.data
            }

            addHistory(OrderHistoryOperation.CANCEL_EXECUTOR, myUser, mOrder, executor.toJson())

            mOrder = orderDao.save(mOrder)

            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )
        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "U dont have permission for this order")
    }

    @PutMapping("/{id}/status/set/done")
    fun done(@RequestHeader(name = Config.tokenParameterName) token: String,
             @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.status != OrderStatus.EXECUTED.data)
            return errorResponse(HttpStatus.NOT_FOUND, "Order not executed yet")

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.app.partner.id == myUser.id) {

            mOrder.status = OrderStatus.DONE.data

            addHistory(OrderHistoryOperation.CLOSE, myUser, mOrder, "")

            mOrder = orderDao.save(mOrder)

            cashRepository.circularOrder(mOrder)

            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You haven`t permission for this order")
    }

    @PutMapping("/{id}/status/set/cancel")
    fun cancel(@RequestHeader(name = Config.tokenParameterName) token: String,
               @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.status == OrderStatus.EXECUTED.data)
            return errorResponse(HttpStatus.NOT_FOUND, "Order is already executed")

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.app.partner.id == myUser.id) {

            mOrder.status = OrderStatus.CANCEL.data

            addHistory(OrderHistoryOperation.CANCEL, myUser, mOrder, "")

            mOrder = orderDao.save(mOrder)

            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You haven`t permission for this order")
    }

    @PutMapping("/{id}/status/set/executed")
    fun executed(@RequestHeader(name = Config.tokenParameterName) token: String,
                 @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.status != OrderStatus.EXECUTING.data)
            return errorResponse(HttpStatus.NOT_FOUND, "Order is not executing yet")

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.executor?.id == myUser.id) {

            mOrder.status = OrderStatus.EXECUTED.data

            addHistory(OrderHistoryOperation.EXECUTED, myUser, mOrder, "")

            mOrder = orderDao.save(mOrder)

            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You haven`t permission for this order")
    }

    @PutMapping("/{id}/status/set/executing")
    fun executing(@RequestHeader(name = Config.tokenParameterName) token: String,
                  @PathVariable(name = "id") id: Int): ResponseEntity<DataResponse<OrderEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        var mOrder = orderDao.findById(id).get()

        if (mOrder.status != OrderStatus.PROCESS.data)
            return errorResponse(HttpStatus.NOT_FOUND, "Order is not executing yet")

        if (myUser.isEditor
                || myUser.isSuperAdmin
                || myUser.isAdmin
                || mOrder.executor?.id == myUser.id) {

            mOrder.status = OrderStatus.EXECUTING.data

            addHistory(OrderHistoryOperation.EXECUTING, myUser, mOrder, "")

            mOrder = orderDao.save(mOrder)

            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = mOrder
                    ),
                    HttpStatus.OK
            )

        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You haven`t permission for this order")
    }

    private fun addHistory(operation: OrderHistoryOperation,
                           user: UserEntity,
                           orderEntity: OrderEntity,
                           data: String) {
        orderHistoryController.add(
                OrderHistoryEntity(
                        order = orderEntity,
                        user = user,
                        operation = operation.data
                )
        )
    }

}

fun Any.toJson() = this.toString()

fun <T> errorResponse(status: HttpStatus, error: String) = ResponseEntity(
        DataResponse<T>(
                success = false,
                error = error,
                data = null
        ),
        status
)