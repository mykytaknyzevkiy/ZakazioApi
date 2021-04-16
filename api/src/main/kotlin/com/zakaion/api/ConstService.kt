package com.zakaion.api

import org.springframework.beans.factory.annotation.Value
import org.springframework.core.env.Environment
import org.springframework.stereotype.Service

@Service
class ConstService(
    env: Environment
) {
    val apiUrl: String = env.getProperty("local.api.url")!!

    val crmUrl: String = env.getProperty("local.crm.url")!!

    val cloudPaymentPublicKey: String = env.getProperty("cloudpayment.key.public")!!

    val cloudPaymentPrivateKey: String = env.getProperty("cloudpayment.key.private")!!

    val fileStorageUrl: String = env.getProperty("file.storege.url")!!
}