package com.zakaion.api

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

var appVersion: String = "no"

@SpringBootApplication
class ZakazioApplication

fun main(args: Array<String>) {
    runApplication<ZakazioApplication>(*args)
}

/*
server.ssl.key-store-type=PKCS12
server.ssl.key-store=classpath:keystore/baeldung.p12
server.ssl.key-store-password=12345678
server.ssl.key-alias=hk

security.require-ssl=true
 */