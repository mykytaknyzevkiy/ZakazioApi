package com.zakaion.api.service

import com.zakaion.api.dao.OrderDao
import com.zakaion.api.entity.order.OrderStatus
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service

@Service
class OrderService(private val orderDao: OrderDao,
                   private val notificationService: NotificationService) {

    fun startExecutorWaitingTimerToStart(orderID: Long, executorID: Long) {
        GlobalScope.launch(Dispatchers.IO) {
            delay(Preference.executorWaitingTimeToStart * 60 * 60 * 1000L)
            val order = orderDao.findByIdOrNull(orderID) ?: return@launch

            if (order.status == OrderStatus.PROCESS && order.executor?.id == executorID) {
                notificationService.finishExecutorWaitingTimeToStart(order)
                order.executor = null
                orderDao.save(order)
            }
        }
    }

}