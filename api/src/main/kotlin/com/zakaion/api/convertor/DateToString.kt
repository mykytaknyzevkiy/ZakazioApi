package com.zakaion.api.convertor

import org.springframework.core.convert.converter.Converter
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.*


class DateToString : Converter<Date, String> {
    override fun convert(source: Date): String? {
        val df: DateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm")
        return df.format(source)
    }
}