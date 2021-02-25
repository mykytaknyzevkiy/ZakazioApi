package com.zakaion.api.controller.payment

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.TransactionInDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.AddPayModel
import com.zakaion.api.model.DataResponse
import com.zakaion.api.service.TransactionService
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["payment"])
class PaymentController(
        private val userDao: UserDao,
        private val transactionService: TransactionService,
        private val userFactory: UserFactory,
        private val transactionInDao: TransactionInDao
) : BaseController() {

    @GetMapping("/{userID}/balance")
    fun balance(@PathVariable("userID") userID: Long) : DataResponse<Float> {
        return DataResponse.ok(
                transactionService.userBalance(userID)
        )
    }

    @PostMapping("/{userID}/add/pay")
    fun addPay(@PathVariable("userID") userID: Long,
               @RequestBody addPayModel: AddPayModel) : DataResponse<Nothing?> {
        val myUser = userDao.findById(userID).orElseGet {
            throw NotFound()
        }

        transactionInDao.save(
                TransactionInEntity(
                        amount = addPayModel.amount,
                        user = myUser,
                        card = null,
                        order = null
                )
        )

        return DataResponse.ok(null)
    }

}