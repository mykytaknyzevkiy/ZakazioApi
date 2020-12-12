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
                          private val emailService: EmailService) {

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
            emailService.sendMsg(when {
                orderEntity.partner != null -> orderEntity.partner!!.phoneNumber?:""
                orderEntity.executor != null -> orderEntity.executor!!.phoneNumber?:""
                else -> orderEntity.client.phoneNumber?:""
            }, msg)
        }
    }

}