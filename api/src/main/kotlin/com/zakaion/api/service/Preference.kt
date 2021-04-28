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

    var orderSumOutPercent: Int
        get() {
            val key = "orderSumOutPercent"

            return properties.getInt(key, 30)
        }
        set(value) {
            val key = "orderSumOutPercent"

            properties.putInt(key, value)
        }

    var orderPartnerPercent: Int
        get() {
            val key = "orderPartnerPercent"

            return properties.getInt(key, 10)
        }
        set(value) {
            val key = "orderPartnerPercent"

            properties.putInt(key, value)
        }

    var executorPartnerPercent: Int
        get() {
            val key = "executorPartnerPercent"

            return properties.getInt(key, 10)
        }
        set(value) {
            val key = "executorPartnerPercent"

            properties.putInt(key, value)
        }

    //Hours
    var executorWaitingTimeToStart: Int
        get() {
            val key = "executorWaitingTimeToStart"

            return properties.getInt(key, 5)
        }
        set(value) {
            val key = "executorWaitingTimeToStart"

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

    var onExecutorInOrder: Boolean
        get() {
            val key = "${type}_onExecutorInOrder"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_onExecutorInOrder"

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

    var onOrderStatus: Boolean
        get() {
            val key = "${type}_onOrderStatus"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_onOrderStatus"

            properties.putBoolean(key, value)
        }

    var finishExecutorWaitingTimeToStart: Boolean
        get() {
            val key = "${type}_finishExecutorWaitingTimeToStart"

            return properties.getBoolean(key, true)
        }
        set(value) {
            val key = "${type}_finishExecutorWaitingTimeToStart"

            properties.putBoolean(key, value)
        }

}

object Contacts {

    private val properties: Preferences = Preferences.userRoot().node(javaClass.name)

    var companyName: String
        get() {
            val key = "companyName"

            return properties.get(key, "companyName")
        }
        set(value) {
            val key = "companyName"

            properties.put(key, value)
        }

    var phoneNumber: String
        get() {
            val key = "phoneNumber"

            return properties.get(key, "phoneNumber")
        }
        set(value) {
            val key = "phoneNumber"

            properties.put(key, value)
        }

    var email: String
        get() {
            val key = "email"

            return properties.get(key, "email")
        }
        set(value) {
            val key = "email"

            properties.put(key, value)
        }

    var facebook: String
        get() {
            val key = "facebook"

            return properties.get(key, "facebook")
        }
        set(value) {
            val key = "facebook"

            properties.put(key, value)
        }

    var instagram: String
        get() {
            val key = "instagram"

            return properties.get(key, "instagram")
        }
        set(value) {
            val key = "instagram"

            properties.put(key, value)
        }

    var twitter: String
        get() {
            val key = "twitter"

            return properties.get(key, "twitter")
        }
        set(value) {
            val key = "twitter"

            properties.put(key, value)
        }

    var linkedIn: String
        get() {
            val key = "LinkedIn"

            return properties.get(key, "LinkedIn")
        }
        set(value) {
            val key = "LinkedIn"

            properties.put(key, value)
        }
}