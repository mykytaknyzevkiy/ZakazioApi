package com.zakaion.api

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.info.BuildProperties


object Config {

    /*@Autowired
    lateinit var buildProperties: BuildProperties*/

    const val genUrl = "/api/v1"

    const val tokenParameterName = "auth"

    var version = "6"
}