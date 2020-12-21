package com.zakaion.api.service

import com.zakaion.api.dao.UserDao
import com.zakaion.api.dao.UserDeviceDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.UserEntity
import org.springframework.stereotype.Service

@Service
class NotificationService(private val userDao: UserDao,
                          private val userDeviceDao: UserDeviceDao,
                          private val smsService: SmsService,
                          private val emailService: EmailService,
                          private val token: AuthTokenService) {

    private fun sendGCM(msg: String, user: UserEntity) {
        //TODO(Send mesg via gcm)
    }

    fun onCreateOrder(orderEntity: OrderEntity) {
        val msg = (if (orderEntity.app != null) Templates.createOrderViaApp else Templates.createOrder)
                .replace(TemplatesValueKey.app, orderEntity.app?.name?:"")
                .replace(TemplatesValueKey.user, when {
                    orderEntity.app != null -> "${orderEntity.partner?.firstName} ${orderEntity.partner?.lastName} ${orderEntity.partner?.middleName}"
                    orderEntity.partner != null -> "${orderEntity.partner?.firstName} ${orderEntity.partner?.lastName} ${orderEntity.partner?.middleName}"
                    orderEntity.executor != null -> "${orderEntity.executor?.firstName} ${orderEntity.executor?.lastName} ${orderEntity.executor?.middleName}"
                    else -> "${orderEntity.client.firstName} ${orderEntity.client.lastName} ${orderEntity.client.middleName}"
                })
                .replace(TemplatesValueKey.orderID, orderEntity.id.toString())

        sendGCM(msg, when {
            orderEntity.partner != null -> orderEntity.partner!!
            orderEntity.executor != null -> orderEntity.executor!!
            else -> orderEntity.client
        })

        if (EmailNotificationPermitted.createOrder) {
            emailService.sendMsg(when {
                orderEntity.partner != null -> orderEntity.partner!!.email?:""
                orderEntity.executor != null -> orderEntity.executor!!.email?:""
                else -> orderEntity.client.email?:""
            }, msg)
        }

        if (PhoneNotificationPermitted.createOrder) {
            smsService.sendMsg(when {
                orderEntity.partner != null -> orderEntity.partner!!.phoneNumber?:""
                orderEntity.executor != null -> orderEntity.executor!!.phoneNumber?:""
                else -> orderEntity.client.phoneNumber?:""
            }, msg)
        }
    }

    fun onYouOrderExecutor(orderEntity: OrderEntity) {
        val executor = orderEntity.executor!!

        val msg = Templates.youExecutorOrder
                .replace(TemplatesValueKey.orderID, orderEntity.id.toString())

        sendGCM(msg, executor)

        if (EmailNotificationPermitted.youExecutorOrder) {
            emailService.sendMsg(executor.email?:"", msg)
        }

        if (PhoneNotificationPermitted.youExecutorOrder) {
            smsService.sendMsg(executor.password?:"", msg)
        }
    }

    fun onClientHasExecutorOrder(orderEntity: OrderEntity) {
        val client = orderEntity.client

        val msg = Templates.clientHasExecutorOrder
                .replace(TemplatesValueKey.orderID, orderEntity.id.toString())
                .replace(TemplatesValueKey.user,
                        "${orderEntity.executor?.firstName} ${orderEntity.executor?.lastName} ${orderEntity.executor?.middleName}")

        sendGCM(msg, client)

        if (EmailNotificationPermitted.clientHasExecutor)
            emailService.sendMsg(client.email?:"", msg)

        if (PhoneNotificationPermitted.clientHasExecutor)
            smsService.sendCode(client.phoneNumber?:"", msg)

    }

    fun onClientOrderInWork(orderEntity: OrderEntity) {
        val client = orderEntity.client

        val msg = Templates.clientOrderInWork
                .replace(TemplatesValueKey.orderID, orderEntity.id.toString())

        sendGCM(msg, client)

        if (EmailNotificationPermitted.clientOrderInWork)
            emailService.sendMsg(client.email?:"", msg)

        if (PhoneNotificationPermitted.clientOrderInWork)
            smsService.sendCode(client.phoneNumber?:"", msg)
    }

    fun addExecutorFeedback(orderEntity: OrderEntity) {
        val url = Preference.feedBackUrl
                .replace(TemplatesValueKey.token,
                        token.generateFeedbackToken(orderEntity.id, orderEntity.executor?.id?:0L)
                )

        val msg = Templates.addExecutorFeedback
                .replace(TemplatesValueKey.orderID, orderEntity.id.toString())
                .replace(TemplatesValueKey.user, "${orderEntity.client.firstName} ${orderEntity.client.lastName} ${orderEntity.client.middleName}")
                .replace(TemplatesValueKey.url, url)

        smsService.sendCode(orderEntity.executor?.phoneNumber?:"", msg)
    }

    fun addClientFeedback(orderEntity: OrderEntity) {
        val url = Preference.feedBackUrl
                .replace(TemplatesValueKey.token,
                        token.generateFeedbackToken(orderEntity.id, orderEntity.client.id)
                )

        val msg = Templates.addClientFeedback
                .replace(TemplatesValueKey.orderID, orderEntity.id.toString())
                .replace(TemplatesValueKey.user, "${orderEntity.executor?.firstName} ${orderEntity.executor?.lastName} ${orderEntity.executor?.middleName}")
                .replace(TemplatesValueKey.url, url)

        smsService.sendCode(orderEntity.executor?.phoneNumber?:"", msg)
    }

}