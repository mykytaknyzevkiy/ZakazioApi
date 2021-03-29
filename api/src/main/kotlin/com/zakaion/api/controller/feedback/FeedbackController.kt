package com.zakaion.api.controller.feedback

import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.order.FeedbackEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.OrderFactor
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.FeedbackRequest
import com.zakaion.api.model.FeedbackResponse
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["feedback"])
class FeedbackController(
    private val userFactory: UserFactory,
    private val orderDao: OrderDao,
    private val feedbackDao: FeedbackDao,
    private val orderFactor: OrderFactor
) {

    @PostMapping("/order/{ORDER_ID}/add")
    fun add(@RequestBody feedbackRequest: FeedbackRequest,
            @PathVariable("ORDER_ID") orderID: Long) : DataResponse<Nothing?> {
        val myUser = userFactory.myUser
        val order = orderDao.findById(orderID).orElseGet {
            throw NotFound()
        }

        val feedbackUser = if (myUser.id == order.client.id && order.executor != null)
            order.executor!!
        else if (myUser.id == order?.executor?.id)
            order.client
        else
            throw BadParams()

        feedbackDao.save(
            FeedbackEntity(
                order = order,
                user = feedbackUser,
                stars = feedbackRequest.stars,
                comments = feedbackRequest.text
            )
        )

        return DataResponse.ok(null)
    }

    @GetMapping("/order/{ORDER_ID}/executor")
    fun orderExecutor(@PathVariable("ORDER_ID") orderID: Long) : DataResponse<FeedbackResponse> {
        val order = orderDao.findById(orderID).orElseGet {
            throw NotFound()
        }

        if (order.executor == null)
            throw BadParams()

        val feedBack = feedbackDao.feedBack(
            userID = order.executor!!.id,
            orderID = order.id
        ).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(
            FeedbackResponse(
                id = feedBack.id,
                comment = feedBack.comments,
                stars = feedBack.stars,
                creationDateTime = feedBack.creationDateTime,
                user = userFactory.create(feedBack.user) ?: throw BadParams(),
                order = orderFactor.create(feedBack.order)
            )
        )
    }

    @GetMapping("/order/{ORDER_ID}/client")
    fun orderClient(@PathVariable("ORDER_ID") orderID: Long) : DataResponse<FeedbackResponse> {
        val order = orderDao.findById(orderID).orElseGet {
            throw NotFound()
        }

        val feedBack = feedbackDao.feedBack(
            userID = order.client.id,
            orderID = order.id
        ).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(
            FeedbackResponse(
                id = feedBack.id,
                comment = feedBack.comments,
                stars = feedBack.stars,
                creationDateTime = feedBack.creationDateTime,
                user = userFactory.create(feedBack.user) ?: throw BadParams(),
                order = orderFactor.create(feedBack.order)
            )
        )
    }

    @GetMapping("/user/{USER_ID}")
    fun user(pageable: Pageable, @PathVariable("USER_ID") userID: Long) : DataResponse<Page<FeedbackResponse>> {
        return DataResponse.ok(
            feedbackDao.feedBacks(pageable, userID).map { feedBack->
                FeedbackResponse(
                    id = feedBack.id,
                    comment = feedBack.comments,
                    stars = feedBack.stars,
                    creationDateTime = feedBack.creationDateTime,
                    user = userFactory.create(feedBack.user) ?: throw BadParams(),
                    order = orderFactor.create(feedBack.order)
                )
            }
        )
    }

}