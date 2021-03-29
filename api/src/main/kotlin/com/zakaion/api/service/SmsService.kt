package com.zakaion.api.service

import org.springframework.stereotype.Service

@Service
class SmsService {

    fun sendMsg(phoneNumber: String, msg: String) {
        //TODO(Send sms)
    }

    fun sendCode(phoneNumber: String, code: String) {
        val msg = Templates.smsAuth
                .replace(TemplatesValueKey.smsCode, code)

        sendMsg(phoneNumber, msg)
    }

}