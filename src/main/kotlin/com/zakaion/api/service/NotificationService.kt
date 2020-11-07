package com.zakaion.api.service

import com.zakaion.api.dao.UserDao
import com.zakaion.api.dao.UserDeviceDao
import org.springframework.stereotype.Service

@Service
class NotificationService(private val userDao: UserDao,
                          private val userDeviceDao: UserDeviceDao) {

}