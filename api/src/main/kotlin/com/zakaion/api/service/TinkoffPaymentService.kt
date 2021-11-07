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
import com.zakaion.api.unit.RsaCryptoMapi
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.http.HttpEntity
import org.springframework.stereotype.Service
import org.springframework.util.Base64Utils.encodeToString
import java.nio.file.Files
import java.nio.file.Paths
import java.security.KeyFactory
import java.security.KeyStore
import java.security.MessageDigest
import java.security.PrivateKey
import java.security.spec.PKCS8EncodedKeySpec
import java.util.*


@Service
class TinkoffPaymentService(
    private val restTemplateBuilder: RestTemplateBuilder,
    constService: ConstService,
    private val orderDao: OrderDao,
    private val userDao: UserDao,
    private val tinkoffPaymentDao: TinkoffPaymentDao,
    private val transactionOutDao: TransactionOutDao,
) {

    private val restTemplate = restTemplateBuilder.build()

    private val url = "https://securepay.tinkoff.ru/v2/"

    private val e2eUrl = "https://securepay.tinkoff.ru/e2c/v2/"

    private val terminalKey = "1620645292011"

    private val password = "kn3u1su9vq89j9b3"

    fun createPaymentUrl(amount: Double,
                              orderID: Long,
                              userID: Long): String {
        val user = userDao.findById(userID).get()


        val map = HashMap<String, Any>()
        map["Amount"] = amount * 10
        map["TerminalKey"] = terminalKey
        map["OrderId"] = orderID.toString()
        map["StartSpAccumulation"] = "1N"
        map["NotificationUrl"] = "https://api.zakazy.online/api/v1/payment/on/payment"
        map["Receipt"] = hashMapOf<String, Any?>().apply {
            put("Email", user.email ?: "")
            user.phoneNumber?.let {
                put("Phone", it)
            }
            put("EmailCompany", "receipt@zakazy.online")
            put("Taxation", "usn_income")
            put("Items", arrayListOf(
                hashMapOf<String, Any?>().apply {
                    put("Name", "Комисия от заказа")
                    put("Price" , amount * 10)
                    put("Amount" , amount * 10)
                    put("Quantity" , 1.0)
                    put("PaymentMethod" , "full_prepayment")
                    put("PaymentObject" , "commodity")
                    put("Tax" , "usn_income")
                }
            ))
        }

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map)

        val postForEntity = restTemplate.postForObject(url + "Init/", entity, String::class.java)

        println(postForEntity)

        val fromJson = Gson().fromJson(postForEntity, CreatePaymentResponse::class.java)

        tinkoffPaymentDao.save(
            TinkoffPaymentEntity(
                user = userDao.findById(userID).get(),
                order = orderDao.findById(orderID).get(),
                paymentID = fromJson.paymentId!!,
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
        map["Token"] = (password + paymentId + terminalKey).sha256().toLowerCase()

        // build the request
        val entity: HttpEntity<Map<String, Any>> = HttpEntity(map)

        println(Gson().toJson(map))

        val postForEntity = restTemplate.postForObject(url + "GetState/", entity, String::class.java)

        println(postForEntity)

        val fromJson = Gson().fromJson(postForEntity, CreatePaymentResponse::class.java)

        val tinPay = tinkoffPaymentDao.findByPaymentID(paymentId).get()

        if (tinPay.status == TinkoffPaymentStatus.CONFIRM)
            return

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

    fun addCard(userID: Long): String {
        val rBody = hashMapOf<String, String>().apply {
            put("TerminalKey", terminalKey)
            put("CustomerKey", userID.toString())
            put("CheckType", "3DSHOLD")

            val data = RsaCryptoMapi().concatValues(this)

            val digestData = RsaCryptoMapi().calcDigest(data.toByteArray())

            put("DigestValue", encodeToString(digestData))

            val keyFile = "src/main/resources/keystore/tin_cert.pem"

            val pKey = privateKey(keyFile)

            val signatureValue = RsaCryptoMapi().calcSignature(
                pKey,
                digestData
            )

            put("SignatureValue", encodeToString(signatureValue))

            put("X509SerialNumber", "6b0000044dbff2245749c2be0f00000000044d")
        }

        // build the request
        val postForEntity = restTemplate.postForObject(url + "AddCard/", HttpEntity(rBody), String::class.java)

        println(postForEntity)

        val fromJson = Gson().fromJson(postForEntity, CreatePaymentResponse::class.java)
        
        return fromJson.paymentURL!!
    }

    fun privateKey(filename: String): PrivateKey? {
        val keyBytes: ByteArray = Files.readAllBytes(Paths.get(filename))
        val spec = PKCS8EncodedKeySpec(keyBytes)
        val kf: KeyFactory = KeyFactory.getInstance("RSA")
        return kf.generatePrivate(spec)
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
    val paymentId: String?,
    @SerializedName("RequestKey")
    val requestKey: String?,
    @SerializedName("PaymentURL")
    val paymentURL: String?,
    @SerializedName("Status")
    val status: String?
)