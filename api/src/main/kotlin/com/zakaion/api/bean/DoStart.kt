package com.zakaion.api.bean

import com.fasterxml.jackson.annotation.JsonCreator
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule
import com.zakaion.api.appVersion
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.service.StorageService
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder
import java.text.SimpleDateFormat


@Configuration
class DoStart(private val userDao: UserDao,
              private val storageService: StorageService) {

    @Bean
    fun start() {
        appVersion = "2-3"
        if (!userDao.findAll().any { it.role == RoleType.SUPER_ADMIN }) {
            userDao.save(
                    UserEntity(
                            firstName = "Super",
                            lastName = "Admin",
                            middleName = "Zakazy",
                            avatar = null,
                            email = "super_admin@zakazy.online",
                            phoneNumber = "00000000000",
                            password = "eiucvojkochoer",
                            role = RoleType.SUPER_ADMIN
                    )
            )
        }
        storageService.init()
    }

    @Bean
    fun jacksonBuilder(): Jackson2ObjectMapperBuilder? {
        val b = Jackson2ObjectMapperBuilder()
        b.indentOutput(true).dateFormat(SimpleDateFormat("yyyy-MM-dd HH:mm"))
        return b
    }

    @Bean
    fun parameterNamesModule(): ParameterNamesModule {
        return ParameterNamesModule(JsonCreator.Mode.PROPERTIES)
    }

    /*@Bean
    fun requestLoggingFilter(): CommonsRequestLoggingFilter? {
        val loggingFilter = CommonsRequestLoggingFilter()
        loggingFilter.setIncludeClientInfo(true)
        loggingFilter.setIncludeQueryString(true)
        loggingFilter.setIncludePayload(true)
        loggingFilter.setMaxPayloadLength(6400000)
        return loggingFilter
    }*/

}