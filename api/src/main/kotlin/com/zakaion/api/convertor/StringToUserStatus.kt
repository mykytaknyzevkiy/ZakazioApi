package com.zakaion.api.convertor

import com.zakaion.api.entity.user.UserStatus
import org.springframework.core.convert.converter.Converter

class StringToUserStatus : Converter<String, UserStatus> {

    override fun convert(source: String): UserStatus =
        UserStatus.valueOf(source.toUpperCase())
}