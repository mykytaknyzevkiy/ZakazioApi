package com.zakaion.socket.constoller

import com.zakaion.socket.module.ImportOrderProcessModel
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.SendTo
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.PathVariable

@Controller
class OrderController {

    @MessageMapping("/order/import/process")
    @SendTo("/topic/order/import/process")
    fun importProcess(message: ImportOrderProcessModel): ImportOrderProcessModel {
        return  message.copy()
    }

    @MessageMapping("/order/import/done")
    @SendTo("/topic/order/import/done")
    fun importDone(message: ImportOrderProcessModel): ImportOrderProcessModel {
        return  message.copy()
    }

}