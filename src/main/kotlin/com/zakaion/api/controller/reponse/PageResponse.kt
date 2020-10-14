package com.zakaion.api.controller.reponse

data class PageResponse<T>(
        val pageNo: Int,
        val maxPages: Int,
        var items: List<T>
)