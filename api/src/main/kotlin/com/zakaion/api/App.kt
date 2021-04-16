package com.zakaion.api

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import java.util.*

var appVersion: String = "no-3333"

@SpringBootApplication
class ZakazioApplication

fun main(args: Array<String>) {
    TimeZone.setDefault(TimeZone.getTimeZone("UTC"))
    runApplication<ZakazioApplication>(*args)
}

/*
server.ssl.key-store-type=PKCS12
server.ssl.key-store=classpath:keystore/baeldung.p12
server.ssl.key-store-password=12345678
server.ssl.key-alias=hk

security.require-ssl=true
 */