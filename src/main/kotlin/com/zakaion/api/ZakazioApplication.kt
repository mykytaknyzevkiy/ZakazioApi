package com.zakaion.api

import com.zakaion.api.repository.StorageService
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.web.client.RestTemplate


@SpringBootApplication
//@EnableConfigurationProperties(StorageProperties.class)
class ZakazioApplication

fun main(args: Array<String>) {
	runApplication<ZakazioApplication>(*args)
}

@Bean
fun init(storageService: StorageService): CommandLineRunner? {
	return CommandLineRunner { args: Array<String?>? ->
		//storageService.deleteAll()
		storageService.init()
	}
}

@Bean
fun restTemplate(): RestTemplate {
	return RestTemplate()
}