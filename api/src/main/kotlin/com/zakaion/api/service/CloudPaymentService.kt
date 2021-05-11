package com.zakaion.api.service

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.zakaion.api.ConstService
import com.zakaion.api.model.AddCardModel
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.http.client.support.BasicAuthorizationInterceptor
import org.springframework.stereotype.Service
import org.springframework.web.client.postForEntity
import java.util.*
import java.util.HashMap

@Service
class CloudPaymentService(
    private val restTemplateBuilder: RestTemplateBuilder,
    constService: ConstService
) {

    private val restTemplate = restTemplateBuilder.build().apply {
        interceptors.add(
            BasicAuthorizationInterceptor(constService.cloudPaymentPublicKey, constService.cloudPaymentPrivateKey)
        )
    }

    private val headers = HttpHeaders().apply {
        contentType = MediaType.APPLICATION_JSON
        accept = Collections.singletonList(MediaType.APPLICATION_JSON)
    }

    fun makePayment(userName: String,
                    userIpAddress: String,
                    crypto: String,
                    amount: Int): CloudPaymentResponse? {

        val url = "https://api.cloudpayments.ru/payments/cards/charge"

        // create a map for post parameters
        val map = HashMap<String, Any>()
        map["Amount"] = amount
        map["Currency"] = "RUB"
        map["CardCryptogramPacket"] = crypto
        map["Name"] = userName
        map["IpAddress"] = "123.123.123.123"

        println(Gson().toJson(map))

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map, headers)

        val postForEntity = restTemplate.postForObject(url, entity, String::class.java)

        return Gson().fromJson(postForEntity, CloudPaymentResponse::class.java)
    }

    fun process3ds(transactionId: String,
                   paRes: String): CloudPaymentResponse? {
        val url = "https://api.cloudpayments.ru/payments/cards/post3ds"

        // create a map for post parameters
        val map = HashMap<String, Any>().apply {
            this["TransactionId"] = transactionId
            this["PaRes"] = paRes
        }

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map, headers)

        val postForEntity = restTemplate.postForObject(url, entity, String::class.java)

        return Gson().fromJson(postForEntity, CloudPaymentResponse::class.java)
    }

    fun get3dsWeb(transactionId: Int, paReq: String, acsUrl: String, userID: Long, bankCardID: Long) : String {
        val map = HashMap<String, Any>().apply {
            this["PaReq"] = paReq
            this["TermUrl"] = "http://localhost:8080/api/v1/payment/$userID/cloudpayment/3ds/process/$bankCardID"
            this["MD"] = transactionId
        }

        val headers = HttpHeaders().apply {
            //contentType = MediaType.MULTIPART_FORM_DATA
            accept = Collections.singletonList(MediaType.TEXT_HTML)
        }

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map, headers)

        val postForEntity = restTemplate.postForObject(acsUrl, entity, String::class.java)

        return postForEntity ?: "NO"
    }

    fun outSum(cardCrypto: String,
               amount: Float,
               userID: Long,
               cardHolderName: String): CloudPaymentResponse? {
        val restTemplate = restTemplateBuilder.build().apply {
            interceptors.add(
                BasicAuthorizationInterceptor("pk_f99204e4f93226fab0fb854caa689", "bea41d186cd7ca8c78e70b7ec7e6a501")
            )
        }

        val url = "https://api.cloudpayments.ru/payments/cards/topup"

        // create a map for post parameters
        val map = HashMap<String, Any>().apply {
            this["Name"] = cardCrypto
            this["CardCryptogramPacket"] = cardCrypto
            this["Amount"] = amount
            this["AccountId"] = userID.toString()
            this["Currency"] = "RUB"
        }

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map, headers)

        val postForEntity = restTemplate.postForObject(url, entity, String::class.java)

        return Gson().fromJson(postForEntity, CloudPaymentResponse::class.java)
    }
}

data class CloudPaymentResponse(
    @SerializedName("Success")
    val success: Boolean,
    @SerializedName("Message")
    val message: String?,
    @SerializedName("Model")
    val model: CloudPaymentModel?
)

data class CloudPaymentModel(
    @SerializedName("TransactionId")
    val transactionId: Int?,
    @SerializedName("PaReq")
    val paReq: String?,
    @SerializedName("AcsUrl")
    val acsUrl: String?,
    @SerializedName("Amount")
    val amount: Float?
)