package com.zakaion.api

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

var appVersion: String = "no"

@SpringBootApplication
class ZakazioApplication

fun main(args: Array<String>) {
	runApplication<ZakazioApplication>(*args)
}