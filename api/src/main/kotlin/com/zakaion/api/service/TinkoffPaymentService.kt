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
import org.springframework.util.Base64Utils.encodeToString
import java.io.BufferedReader
import java.io.StringReader
import java.security.*
import java.security.spec.PKCS8EncodedKeySpec
import java.util.*
import java.util.stream.Collectors
import java.util.Base64;


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

            val data = concatValues(this)

            val digestData = calcDigest(data.toByteArray())

            put("DigestValue", encodeToString(digestData))

            val pKey = privateKey()

            val signatureValue = calcSignature(
                pKey,
                digestData
            )

            put("SignatureValue", encodeToString(signatureValue))

            put("X509SerialNumber", "6b0000044dbff2245749c2be0f00000000044d")
        }

        // build the request
        val postForEntity = restTemplate.postForObject(e2eUrl + "AddCard/", HttpEntity(rBody), String::class.java)

        println(postForEntity)

        val fromJson = Gson().fromJson(postForEntity, CreatePaymentResponse::class.java)
        
        return fromJson.paymentURL!!
    }

    fun privateKey(): PrivateKey {
        val PRIVATE_KEY = "-----BEGIN PRIVATE KEY-----\n" +
                "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDReeY5n1sIh5El\n" +
                "EHPhuweYXdfwF/3VvNjjy+CqEu5mThTSfG+jQya5ogz13/wSqZLmDVNDbzbfalJ6\n" +
                "ED88VA493IndQJRT0ucVvXgVVYCggaog9XoO7BoAcvAumGrrXR+j6lssk4SUwerU\n" +
                "CyUHNSYEn6gPt/JS+JY9YJL9NQHLtZzkN5wPCxvvOuFWl+aDIfOpWIC84bOd8lzf\n" +
                "5SFLS/Zx4w+uXjFFEoe05VUZD+e5stDrfsisgmn0iR2iLQNVZhAlyxveyDY68qf1\n" +
                "rxsLj6Zf0Ll77ao0gCPoqhHBqXe96BW4ny9IjlNpEM8W+F6GejYyuQ8uaZnJjV+K\n" +
                "wbkAPW3HAgMBAAECggEANpBpHtNalBM0BJKPjNn59X9kUx78uKMTX+roX4TE4pMu\n" +
                "K1HMhptkR/BlLdqlP3s6T4BjEuqyQWnhh/gZcK54czayFpbOzDLgjLIoyG3YLnb4\n" +
                "CNPIcoCfmURXOdvr5dkA9+KA01CttU35zDgG8iSu/X9U+JsynNgx0lUIlLos+JGh\n" +
                "+GQ6d4SABdtIyC6NNqBkZXbPxbiyF3T5RBBj9mb9u3WR4/uyOFoHYFjEvRdsdp3c\n" +
                "EwKwZXktbMK+DWA56jfbTMCCUTqzPyVIXrDMFOXq/DuySWssuZlK2QDwtAuhFaXO\n" +
                "sX6TeAk0gWQ+KKoby98DRjn2JCbH6xSjIqnkbR7lIQKBgQD7p7dJftO2LwCRIQ+D\n" +
                "kRhQqUT/N7RSxgftdoTukpo1IAhV5GtH6mfh7Cz2CHmvJrE/QuR1ACbtAL89cIhd\n" +
                "lmj9gFrXu+56csKh6F8a+nLPALnePoCi8fQBPr4w76Ad7QpycsYkwwU1z0Zij+Gq\n" +
                "SB5PF1/r7i1ncIXI2NnXeE5XlwKBgQDVF8HyrnbWl4YE/wgWkTK513agkcCGE6Eu\n" +
                "1mNkVPxBFJ7TYQqtbbzumZXCREa3xXamHYgdiNpP+soO+vKnPS9Y6MY5KbBDDMmI\n" +
                "LKMVJBzjVg0lZPbEJ8dondZwI6fjfeS50pVCRK6VPxUgcDsAwSTGSqSEnpekdLRL\n" +
                "617rXkjhUQKBgF4EFnGatDWH8cpGc6lPd6oK0wAWK4QQ/70zXg5TLtFSGkscfwfr\n" +
                "Bsxck5+HIw7Qgb+Emh0r5V79vHSTqh5spuSuI0Idr8aHQTeDvKQzlNjJCKeC6kP1\n" +
                "6JbefeeCXmtPt2tyfZwWT8f+m+kOn9wh/VDHBsr5vHS8kP6sJRZel8YZAoGBAMfa\n" +
                "TUsm90vRtp8O9W385b9IZfi4WgElfeEorvUVg7Qh+8ex1srLBgwdPUiCsnR+nQW0\n" +
                "4skYZe/m/QTJtTTGfJZ9UhOglrB72LN/ccBNK07HkPLGW22jBTGH/usTdc01cIQb\n" +
                "DWOmeLp+/Hh86cmOW8ghj2TWPNC/p60gZdiHiADRAoGAXEo+HS+calb6P8YULe59\n" +
                "ImBGO+lOkugwAKax24Xr5pZH16J2DpolSkNqoxtjir3/Y7apDbyblT8rT+r8lczz\n" +
                "JMcBXLV0J5NoGUiTj/cG0QZ2LafOJCf+Pa7CsDk0JLXghRqUw+JrrarExxgXcCvs\n" +
                "MXFX2otKZ2tTlu3F68su428=\n" +
                "-----END PRIVATE KEY-----\n"
        val pkcs8Lines = StringBuilder()
        val rdr = BufferedReader(StringReader(PRIVATE_KEY))
        var line: String?
        while (rdr.readLine().also { line = it } != null) {
            pkcs8Lines.append(line)
        }

        // Remove the "BEGIN" and "END" lines, as well as any whitespace


        // Remove the "BEGIN" and "END" lines, as well as any whitespace
        var pkcs8Pem = pkcs8Lines.toString()
        pkcs8Pem = pkcs8Pem.replace("-----BEGIN PRIVATE KEY-----", "")
        pkcs8Pem = pkcs8Pem.replace("-----END PRIVATE KEY-----", "")
        pkcs8Pem = pkcs8Pem.replace("\\s+".toRegex(), "")

        // Base64 decode the result


        // Base64 decode the result
        val pkcs8EncodedBytes: ByteArray = Base64.getDecoder().decode(pkcs8Pem)

        // extract the private key


        // extract the private key
        val keySpec = PKCS8EncodedKeySpec(pkcs8EncodedBytes)
        val kf = KeyFactory.getInstance("RSA")
        return kf.generatePrivate(keySpec)
    }

    fun concatValues(data: Map<String, String>): String {
        return data.keys.stream().sorted().map { o: String? ->
            data[o]
        }.collect(Collectors.joining())
    }

    /**
     * Вычисляет хеш-значение от переданных данных.
     *
     * @param data                сырые данные.
     * @return вычисленное хеш-значение.
     * @throws NoSuchAlgorithmException в случае если необходимый алгоритм не был найден в окружении.
     */
    @Throws(NoSuchAlgorithmException::class)
    fun calcDigest(data: ByteArray): ByteArray {
        val messageDigest = MessageDigest.getInstance("SHA-256")
        messageDigest.update(data)
        return messageDigest.digest()
    }

    /**
     * Формирует подпись для переданных данных.
     *
     * @param key               ключ для формирования подписи.
     * @param data              сырые данные.
     * @return сформированную подпись.
     * @throws NoSuchAlgorithmException в случае если необходимый алгоритм не был найден в окружении.
     * @throws InvalidKeyException      в случае если передан неправильный закрытуый ключ.
     * @throws SignatureException       в случае если при формировании подписи произошла ошибка.
     */
    @Throws(NoSuchAlgorithmException::class, InvalidKeyException::class, SignatureException::class)
    fun calcSignature(key: PrivateKey, data: ByteArray): ByteArray {
        val signature = Signature.getInstance("SHA256withRSA")
        signature.initSign(key)
        signature.update(data)
        return signature.sign()
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