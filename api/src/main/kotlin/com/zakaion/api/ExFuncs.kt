package com.zakaion.api

import com.zakaion.api.entity.user.UserImp
import org.springframework.core.io.ClassPathResource
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageImpl
import org.springframework.data.domain.Pageable
import java.io.BufferedReader
import java.io.InputStream
import java.io.InputStreamReader
import java.util.stream.Collectors


object ExFuncs {

    fun getResourceFileAsString(fileName: String): String {
        val `is`: InputStream = getResourceFileAsInputStream(fileName)
        val reader = BufferedReader(InputStreamReader(`is`))
        return reader.lines().collect(Collectors.joining(System.lineSeparator())) as String
    }

    fun getResourceFileAsInputStream(fileName: String): InputStream {
        return ClassPathResource(fileName).inputStream
    }

    fun <T> List<T>.toPage(pageable: Pageable): Page<T> {
        val start = pageable.offset.toInt()
        val end = (start + pageable.pageSize).coerceAtMost(this.size)
        return PageImpl(this.subList(start, end), pageable, this.size.toLong())
    }

}