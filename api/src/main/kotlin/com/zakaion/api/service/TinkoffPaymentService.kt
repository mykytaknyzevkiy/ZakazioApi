package com.zakaion.api.service

import com.zakaion.api.ConstService
import org.springframework.boot.web.client.RestTemplateBuilder
import org.springframework.stereotype.Service

@Service
class TinkoffPaymentService(private val restTemplateBuilder: RestTemplateBuilder,
                            constService: ConstService
) {

    private val restTemplate = restTemplateBuilder.build()

}