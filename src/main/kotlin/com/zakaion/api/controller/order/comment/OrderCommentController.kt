package com.zakaion.api.controller.order.comment

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.OrderCommentDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.order.OrderComment
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.OrderFactor
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.OrderCommentModel
import com.zakaion.api.model.OrderNModel
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["order/{orderID}/comment"])
class OrderCommentController(private val orderFactor: OrderFactor,
                             private val orderCommentDao: OrderCommentDao,
                             private val userFactory: UserFactory,
                             private val orderDao: OrderDao) : BaseController() {

    @PostMapping("/add")
    fun add(@RequestBody orderCommentModel: OrderCommentModel, @PathVariable("orderID") orderID: Long) : DataResponse<Nothing?> {
        val orderEntity = orderDao.findById(orderID).orElseGet {
            throw NotFound()
        }

        val order = orderFactor
                .create(orderEntity)

        if (!order.commentEnable)
            throw NoPermittedMethod()

        orderCommentDao.save(
                OrderComment(
                        user = userFactory.myUser,
                        comment = orderCommentModel.text,
                        order = orderEntity
                )
        )

        return DataResponse.ok(null)
    }

    @GetMapping("/list")
    fun list(@PathVariable("orderID") orderID: Long, pageable: Pageable) : DataResponse<Page<OrderCommentModel>> {
        orderDao.findById(orderID).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(
                orderCommentDao.findAll(orderID, pageable).map {
                    OrderCommentModel(
                            id = it.id,
                            text = it.comment,
                            user = it.user,
                            creationDateTime = it.creationDateTime
                    )
                }
        )
    }
}