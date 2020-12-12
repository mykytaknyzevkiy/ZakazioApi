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

}

object TemplatesValueKey {

    val smsCode = "{{sms_code}}"

    val user = "{{user}}"

    val orderID = "{{orderID}}"

    val app = "{{app}}"

}


interface NotificationPermitted {
    var createOrder: Boolean
}

abstract class NotificationPermittedImp : NotificationPermitted {
    abstract val type : String

    override var createOrder: Boolean
        get() {
            val key = "${type}_create_order"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_create_order"

            properties.putBoolean(key, value)
        }

}