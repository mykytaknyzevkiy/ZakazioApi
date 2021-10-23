package com.zakaion.api.service

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.zakaion.api.ConstService
import com.zakaion.api.dao.OrderDao
import com.zakaion.api.dao.TransactionOutDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.TinkoffPaymentDao
import com.zakaion.api.entity.TinkoffPaymentEntity
import com.zakaion.api.entity.TinkoffPaymentStatus
import com.zakaion.api.entity.transaction.TransactionOutEntity
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.http.HttpEntity
import org.springframework.stereotype.Service
import java.security.MessageDigest

@Service
class TinkoffPaymentService(private val restTemplateBuilder: RestTemplateBuilder,
                            constService: ConstService,
                            private val orderDao: OrderDao,
                            private val userDao: UserDao,
                            private val tinkoffPaymentDao: TinkoffPaymentDao,
                            private val transactionOutDao: TransactionOutDao,
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
                paymentID = fromJson.paymentId,
                amount = amount.toFloat()
            )
        )

        return fromJson.paymentURL!!
    }

    fun encodeNotification(body: com.fasterxml.jackson.databind.JsonNode) {
        println("onPayment body is $body")

        val paymentId = body.get("PaymentId").asText()

        val map = HashMap<String, Any>()
        map["TerminalKey"] = terminalKey
        map["PaymentId"] = paymentId
        map["Token"] = (password + paymentId + terminalKey).sha256()

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map)

        val postForEntity = restTemplate.postForObject(url + "GetState/", entity, String::class.java)

        println(postForEntity)

        val fromJson = Gson().fromJson(postForEntity, CreatePaymentResponse::class.java)

        val tinPay = tinkoffPaymentDao.findByPaymentID(paymentId).get()

        if (fromJson.status == "CONFIRMED" || fromJson.status == "AUTHORIZED") {
            tinkoffPaymentDao.save(
                tinPay.copy(status = TinkoffPaymentStatus.CONFIRM)
            )

            transactionOutDao.save(
                TransactionOutEntity(
                    amount = tinPay.amount,
                    user = tinPay.user,
                    card = null,
                    order = tinPay.order
                )
            )
        } else {
            tinkoffPaymentDao.save(
                tinPay.copy(status = TinkoffPaymentStatus.FAIL)
            )
        }
    }

}

fun String.sha256(): String {
    val HEX_CHARS = "0123456789ABCDEF"
    val bytes = MessageDigest
        .getInstance("SHA-256")
        .digest(this.toByteArray())
    val result = StringBuilder(bytes.size * 2)

    bytes.forEach {
        val i = it.toInt()
        result.append(HEX_CHARS[i shr 4 and 0x0f])
        result.append(HEX_CHARS[i and 0x0f])
    }

    return result.toString()
}

data class CreatePaymentResponse(
    @SerializedName("Success")
    val success: Boolean,
    @SerializedName("PaymentId")
    val paymentId: String,
    @SerializedName("PaymentURL")
    val paymentURL: String?,
    @SerializedName("Status")
    val status: String?
)