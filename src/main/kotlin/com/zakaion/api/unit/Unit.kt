package com.zakaion.api.unit

import com.zakaion.api.controller.reponse.PageResponse
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException
import java.util.ArrayList
import kotlin.math.ceil


object UnitN {

    fun <T> makePaginationResponse(items: List<T>, pageNo: Int, pageSize: Int): PageResponse<T> {
        val pages = getPages(items, pageSize)
        val maxPages = pages.size

        if (maxPages == 0 && pageNo == 1) {
            return PageResponse(
                    pageNo = pageNo,
                    maxPages = maxPages,
                    items = emptyList()
            )
        }

        else if (maxPages < pageNo) {
            throw ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "page not found"
            )
        }

        return PageResponse(
                pageNo = pageNo,
                maxPages = maxPages,
                items = pages[pageNo - 1]
        )
    }

    private fun <T> getPages(c: Collection<T>, pageSizeN: Int): List<List<T>> {
        val list: List<T> = ArrayList(c)
        var pageSize = pageSizeN

        if (pageSize <= 0 || pageSize > list.size) pageSize = list.size

        val numPages = ceil(list.size.toDouble() / pageSize.toDouble()).toInt()

        val pages: MutableList<List<T>> = ArrayList(numPages)

        var pageNum = 0

        while (pageNum < numPages) {
            pages.add(list.subList(pageNum * pageSize, (++pageNum * pageSize).coerceAtMost(list.size)))
        }

        return pages
    }

}