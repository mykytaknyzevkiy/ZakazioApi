package com.zakaion.api.controller

import com.zakaion.api.unit.Config
import com.zakaion.api.unit.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.dao.OrderCommentDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.OrderCommentEntity
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.model.OrderCommentRequest
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/order/{id}/comment/"])
class OrderCommentController(
        private val userController: UserController,
        private val orderDao: OrderDao,
        private val orderCommentDao: OrderCommentDao) {

    @PostMapping("")
    fun add(@RequestHeader(name = Config.tokenParameterName) token: String,
            @PathVariable(name = "id") id: Int,
            @RequestBody body: OrderCommentRequest): ResponseEntity<DataResponse<OrderCommentEntity>> {
        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        val mOrder = orderDao.findById(id).get()

        if (!myUser.isSuperAdmin &&
                !myUser.isAdmin &&
                !myUser.isEditor &&
                mOrder.executor?.id != myUser.id &&
                mOrder.app.partner.id != myUser.id)
            return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You dont have permission for this order")

        if (body.title.isEmpty() || body.content.isEmpty())
            return errorResponse(HttpStatus.BAD_REQUEST, "params is empty")

        val orderCommentEntity = orderCommentDao.save(
                OrderCommentEntity(
                        title = body.title,
                        content = body.content,
                        user = myUser,
                        order = mOrder
                )
        )

        return ResponseEntity(DataResponse(
                data = orderCommentEntity
        ), HttpStatus.OK)
    }

    @GetMapping("")
    fun list(@RequestHeader(name = Config.tokenParameterName) token: String,
             @PathVariable(name = "id") id: Int,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10):
            ResponseEntity<DataResponse<PageResponse<OrderCommentEntity>>> {

        val myUser = userController.user(token).data as UserEntity

        if (orderDao.findById(id).isEmpty) {
            return errorResponse(HttpStatus.NOT_FOUND, "order not exist")
        }

        val mOrder = orderDao.findById(id).get()

        if (myUser.isSuperAdmin
                || myUser.isAdmin
                || myUser.isEditor
                || mOrder.app.partner.id == myUser.id
                || mOrder.executor?.id == myUser.id
                || mOrder.executor?.partnerID == myUser.id) {
            return ResponseEntity(
                    DataResponse(
                            data = UnitN.makePaginationResponse((orderCommentDao.findAll().filter { it.order.id == mOrder.id }).reversed(), pageNo = page, pageSize = size)
                    ),
                    HttpStatus.OK
            )
        }

        return errorResponse(HttpStatus.METHOD_NOT_ALLOWED, "You dont have permission for this order")

    }


}