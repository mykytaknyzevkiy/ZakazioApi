package com.zakaion.api.service

import com.google.gson.Gson
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.client.support.BasicAuthorizationInterceptor
import org.springframework.stereotype.Service
import java.util.*

@Service
class SmsService(restTemplateBuilder: RestTemplateBuilder) {

    private val restTemplate = restTemplateBuilder.build()

    private val headers = HttpHeaders().apply {
        contentType = MediaType.APPLICATION_JSON_UTF8
        accept = Collections.singletonList(MediaType.APPLICATION_JSON_UTF8)
    }

    fun sendMsg(phoneNumber: String, msg: String) {
        return
        val url = "http://sms:8282/api/v1/message/add"

        // create a map for post parameters
        val map = HashMap<String, Any>()
        map["phoneNumber"] = phoneNumber
        map["content"] = msg

        println(Gson().toJson(map))

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map, headers)

        restTemplate.postForObject(url, entity, String::class.java)
    }

    fun sendCode(phoneNumber: String, code: String) {
        val msg = "Ваш код авторизации $code"

        sendMsg(phoneNumber, msg)
    }

}