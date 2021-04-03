package com.zakaion.api

import org.springframework.core.io.ClassPathResource
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

}