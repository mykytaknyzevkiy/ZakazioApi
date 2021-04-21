package com.zakaion.api.service

import com.zakaion.api.dao.UserDao
import com.zakaion.api.dao.UserDeviceDao
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.order.OrderStatus
import com.zakaion.api.entity.order.OrderStatus.*
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
        val msg = "У вас создан заказ №${orderEntity.id}"

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

    fun onExecutorInOrder(orderEntity: OrderEntity) {
        val executor = orderEntity.executor!!

        val msg = "Вы стали исполнителем заказа №${orderEntity.id}." +
                "\nУ вас есть ${Preference.executorWaitingTimeToStart} часов, чтобы начать работу, иначе заказ с вас снимется и отправится " +
                "в открытый доступ."

        sendGCM(msg, executor)

        if (EmailNotificationPermitted.onExecutorInOrder) {
            emailService.sendMsg(executor.email?:"", msg)
        }

        if (PhoneNotificationPermitted.onExecutorInOrder) {
            smsService.sendMsg(executor.password?:"", msg)
        }
    }

    fun onOrderStatus(orderEntity: OrderEntity) {
        val client = orderEntity.client

        val msg = when (orderEntity.status) {
            PROCESS -> return
            IN_WORK -> "Исполнитель начал работу над вашим заказом №${orderEntity.id}"
            DONE -> "Исполнитель завершил работу над вашим заказом №${orderEntity.id}." +
                    "\nОцените пожалуйста его работу"
            CANCEL -> "Ваш заказ №${orderEntity.id} отменен"
        }

        sendGCM(msg, client)

        if (EmailNotificationPermitted.onOrderStatus)
            emailService.sendMsg(client.email?:"", msg)

        if (PhoneNotificationPermitted.onOrderStatus)
            smsService.sendCode(client.phoneNumber?:"", msg)
    }

    fun finishExecutorWaitingTimeToStart(orderEntity: OrderEntity) {
        val message = "Ваше время на то, чтобы начать исполнение " +
                "заказа №${orderEntity.id} закончилось." +
                "\nЗаказ с вас снят и снова открыт для других исполнителей"

        if (EmailNotificationPermitted.finishExecutorWaitingTimeToStart) {
            emailService.sendMsg(orderEntity.executor?.email?:return, message)
        }

        if (PhoneNotificationPermitted.finishExecutorWaitingTimeToStart) {
            smsService.sendMsg(orderEntity.executor?.phoneNumber?:return, message)
        }
    }

}