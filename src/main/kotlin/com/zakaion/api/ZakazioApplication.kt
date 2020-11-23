package com.zakaion.api

import com.zakaion.api.service.preferenceStoreFile
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.info.BuildProperties
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import java.nio.file.Files

var appVersion: String = "no"

@SpringBootApplication
class ZakazioApplication

fun main(args: Array<String>) {
	runApplication<ZakazioApplication>(*args)
}