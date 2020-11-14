package com.zakaion.api.service

import java.io.File
import java.util.*

private val preferenceStoreFile = File("/tmp/preference")
private val preferenceComment = "Nikita"

object Preference {

    var executorMaxOrder: Int
        get() {
            val key = "executorMaxOrder"

            val properties = Properties()
            properties.load(preferenceStoreFile.inputStream())

            return if (properties.containsKey(key)) {
                properties[key] as Int
            } else
                4
        }
        set(value) {
            val key = "executorMaxOrder"

            val properties = Properties()
            properties.load(preferenceStoreFile.inputStream())

            properties[key] = value

            properties.store(preferenceStoreFile.outputStream(), preferenceComment)
        }

}

object Templates {

    var smsCode: String
        get() {
            val key = "template_sms_code"

            val properties = Properties()
            properties.load(preferenceStoreFile.inputStream())

            return if (properties.containsKey(key)) {
                properties[key] as String
            } else
                "Ваш код: $smsCode"
        }
        set(value) {
            val key = "template_sms_code"

            val properties = Properties()
            properties.load(preferenceStoreFile.inputStream())

            properties[key] = value

            properties.store(preferenceStoreFile.outputStream(), preferenceComment)
        }

}

object TemplatesValueKey {

    val smsCode = "{{sms_code}}"

}