package com.zakaion.api.service

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.zakaion.api.ConstService
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.TinkoffPaymentDao
import com.zakaion.api.entity.TinkoffPaymentEntity
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.http.HttpEntity
import org.springframework.stereotype.Service

@Service
class TinkoffPaymentService(private val restTemplateBuilder: RestTemplateBuilder,
                            constService: ConstService,
                            private val orderDao: OrderDao,
                            private val userDao: UserDao,
                            private val tinkoffPaymentDao: TinkoffPaymentDao
) {

    private val restTemplate = restTemplateBuilder.build()

    private val url = "https://securepay.tinkoff.ru/v2/"

    private val terminalKey = "1620645292011DEMO"

    private val password = "yysndl6kqan152d9"

    fun createPaymentUrl(amount: Double,
                              orderID: Long,
                              userID: Long): String {
        val map = HashMap<String, Any>()
        map["Amount"] = amount * 10
        map["TerminalKey"] = terminalKey
        map["OrderId"] = orderID.toString()
        map["StartSpAccumulation"] = "1N"
        map["NotificationUrl"] = "https://api.zakazy.online/api/v1/payment/on/payment"

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map)

        val postForEntity = restTemplate.postForObject(url + "Init/", entity, String::class.java)

        println(postForEntity)

        val fromJson = Gson().fromJson(postForEntity, CreatePaymentResponse::class.java)

        tinkoffPaymentDao.save(
            TinkoffPaymentEntity(
                user = userDao.findById(userID).get(),
                order = orderDao.findById(orderID).get(),
                paymentID = fromJson.paymentId
            )
        )

        return fromJson.paymentURL
    }

}

data class CreatePaymentResponse(
    @SerializedName("Success")
    val success: Boolean,
    @SerializedName("PaymentId")
    val paymentId: String,
    @SerializedName("PaymentURL")
    val paymentURL: String
)