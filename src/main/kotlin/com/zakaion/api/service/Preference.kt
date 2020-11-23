package com.zakaion.api.service

import com.zakaion.api.service.Preference.properties
import java.io.File
import java.util.*
import java.util.prefs.Preferences




val preferenceStoreFile = File("nikita.k")
private val preferenceComment = "Nikita"

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

}

object TemplatesValueKey {

    val smsCode = "{{sms_code}}"

}

fun Preferences.containsKey(key: String) : Boolean = this.keys().contains(key)