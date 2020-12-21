package com.zakaion.api.service

import com.zakaion.api.service.Preference.properties
import java.io.File
import java.util.*
import java.util.prefs.Preferences

object Preference {

    val properties: Preferences = Preferences.userRoot().node(javaClass.name)

    var executorMaxOrder: Int
        get() {
            val key = "executorMaxOrder"

            return properties.getInt(key, 4)
        }
        set(value) {
            val key = "executorMaxOrder"

            properties.putInt(key, value)
        }

    var feedBackUrl: String
        get() {
            val key = "feedBackUrl"

            return properties.get(key, "http://localhost:8282/feedback/${TemplatesValueKey.token}/add")
        }
        set(value) {
            val key = "feedBackUrl"

            properties.put(key, value)
        }

}

object EmailNotificationPermitted : NotificationPermittedImp() {
    override val type: String
        get() = "email"
}

object PhoneNotificationPermitted : NotificationPermittedImp() {
    override val type: String
        get() = "phone"
}

object Templates {

    var smsAuth: String
        get() {
            val key = "template_sms_code"

            return properties.get(key, "Ваш код: ${TemplatesValueKey.smsCode}")
        }
        set(value) {
            val key = "template_sms_code"

            properties.put(key, value)
        }

    var createOrder: String
        get() {
            val key = "template_create_order"

            return properties.get(key, "Пользователь ${TemplatesValueKey.user} создал заказа с номером ${TemplatesValueKey.orderID}")
        }
        set(value) {
            val key = "template_create_order"

            properties.put(key, value)
        }

    var createOrderViaApp: String
        get() {
            val key = "template_create_order_via_app"

            return properties.get(key, "Приложение ${TemplatesValueKey.app} от ${TemplatesValueKey.user} создал заказа с номером ${TemplatesValueKey.orderID}")
        }
        set(value) {
            val key = "template_create_order_via_app"

            properties.put(key, value)
        }

    var youExecutorOrder: String
        get() {
            val key = "template_you_executor_order"

            return properties.get(key, "Вы стали исполнителем заказа с номером ${TemplatesValueKey.orderID}")
        }
        set(value) {
            val key = "template_you_executor_order"

            properties.put(key, value)
        }

    var clientHasExecutorOrder: String
        get() {
            val key = "template_client_has_executor"

            return properties.get(key, "На ваш заказа с номером ${TemplatesValueKey.orderID} назначен исполнитель ${TemplatesValueKey.user}")
        }
        set(value) {
            val key = "template_client_has_executor"

            properties.put(key, value)
        }

    var clientOrderInWork: String
        get() {
            val key = "template_client_order_in_work"

            return properties.get(key, "Исполнитель вашего заказа с номером ${TemplatesValueKey.orderID} начал работу")
        }
        set(value) {
            val key = "template_client_order_in_work"

            properties.put(key, value)
        }

    var addExecutorFeedback: String
        get() {
            val key = "template_add_executor_feedback"

            return properties.get(key, "Оставьте пожалуйста отзыв про вашего исполнителя " +
                    "${TemplatesValueKey.user} за проект с номером ${TemplatesValueKey.orderID}" + "\n" +
                    TemplatesValueKey.url)
        }
        set(value) {
            val key = "template_add_executor_feedback"

            properties.put(key, value)
        }

    var addClientFeedback: String
        get() {
            val key = "template_add_client_feedback"

            return properties.get(key, "Оставьте пожалуйста отзыв про вашего клиента " +
                    "${TemplatesValueKey.user} за проект с номером ${TemplatesValueKey.orderID}" + "\n" +
                    TemplatesValueKey.url)
        }
        set(value) {
            val key = "template_add_client_feedback"

            properties.put(key, value)
        }

}

object TemplatesValueKey {

    val smsCode = "{{sms_code}}"

    val user = "{{user}}"

    val orderID = "{{orderID}}"

    val app = "{{app}}"

    val url = "{{url}}"

    val token = "{{toke}}"
}

abstract class NotificationPermittedImp {
    abstract val type : String

    var createOrder: Boolean
        get() {
            val key = "${type}_create_order"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_create_order"

            properties.putBoolean(key, value)
        }

    var youExecutorOrder: Boolean
        get() {
            val key = "${type}_you_executor"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_you_executor"

            properties.putBoolean(key, value)
        }

    var clientHasExecutor: Boolean
        get() {
            val key = "${type}_client_has_executor"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_client_has_executor"

            properties.putBoolean(key, value)
        }

    var clientOrderInWork: Boolean
        get() {
            val key = "${type}_client_order_in_work"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_client_order_in_work"

            properties.putBoolean(key, value)
        }

}