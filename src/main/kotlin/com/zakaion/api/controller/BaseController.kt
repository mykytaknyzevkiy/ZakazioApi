package com.zakaion.api.controller

abstract class BaseController {

    fun String.toZUrl() : String {
        return "http://localhost:8080/api/v1/file/$this"
    }

}