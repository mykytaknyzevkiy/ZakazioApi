package com.zakaion.api.bean

import com.zakaion.api.appVersion
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import org.springframework.boot.info.BuildProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.filter.CommonsRequestLoggingFilter




@Configuration
class DoStart(private val buildProperties: BuildProperties,
              private val userDao: UserDao) {

    @Bean
    fun start() {
        appVersion = buildProperties.version
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