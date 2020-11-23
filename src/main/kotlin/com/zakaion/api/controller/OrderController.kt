package com.zakaion.api.controller

import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.FeedbackDao
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.order.AppEntity
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.model.AddOrderModel
import com.zakaion.api.model.DataResponse
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody

class OrderController(private val orderDao: OrderDao,
                      private val userController: UserController,
                      private val feedbackDao: FeedbackDao,
                      private val userDao: UserDao) : BaseController() {

    @PostMapping("/add")
    fun add(@RequestBody addOrderModel: AddOrderModel, appEntity: AppEntity? = null) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        if (addOrderModel.content.isEmpty ||
                addOrderModel.dateLine.isEmpty ||
                addOrderModel.price <= 0)
            throw BadParams()

        if (myUser.role != RoleType.CLIENT &&
                (addOrderModel.clientEmail.isEmpty ||
                        addOrderModel.clientPhone.isEmpty ||
                        addOrderModel.clientFirstName.isEmpty ||
                        addOrderModel.clientLastName.isEmpty ||
                        addOrderModel.clientMiddleName.isEmpty))
            throw BadParams()

        if ((myUser.role == RoleType.EXECUTOR ||
                        myUser.role == RoleType.PARTNER) &&
                (!myUser.isPassportActive ||
                        !myUser.isEmailActive ||
                        !myUser.isPhoneActive))
            throw NoPermittedMethod()

        val client: UserEntity = if (myUser.role == RoleType.CLIENT)
            myUser
        else {
            userDao.findAll()
                    .find { it.phoneNumber == addOrderModel.clientPhone ||
                            it.email == addOrderModel.clientEmail }
                    ?: userDao.save(UserEntity(
                            email = addOrderModel.clientEmail,
                            phoneNumber = addOrderModel.clientPhone,
                            firstName = addOrderModel.clientFirstName,
                            lastName = addOrderModel.clientLastName,
                            middleName = addOrderModel.clientMiddleName
                    ))
        }

        val executor: UserEntity? = when {
            myUser.role == RoleType.EXECUTOR -> myUser
            addOrderModel.executorID != null -> {
                val user: UserEntity = userDao.findById(addOrderModel.executorID).orElseGet {
                    throw BadParams()
                }

                if (user.role != RoleType.EXECUTOR)
                    throw BadParams()

                if (!myUser.isPhoneActive || !myUser.isEmailActive || !myUser.isPassportActive)
                    throw BadParams()

                user
            }
            else -> null
        }

        val orderEntity = orderDao.save(
                OrderEntity(
                        content = addOrderModel.content,
                        price = addOrderModel.price,
                        dateLine = addOrderModel.dateLine,
                        client = client,
                        executor = executor,
                        partner = if (myUser.role == RoleType.PARTNER) myUser else null,
                        app = appEntity
                )
        )
        
        if (executor != null) {
            //TODO(Send notification to executor)
        }

        if (myUser.role == RoleType.PARTNER) {
            //TODO(Send notification to partner)
        }

        //TODO(Send notification to client)

        return DataResponse.ok(null)
    }

}