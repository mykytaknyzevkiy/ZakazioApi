package com.zakaion.api.service

import com.google.gson.Gson
import com.zakaion.api.unit.buildSocket
import org.springframework.messaging.simp.stomp.StompSession
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter
import org.springframework.stereotype.Service
import org.springframework.web.socket.client.standard.StandardWebSocketClient
import org.springframework.web.socket.messaging.WebSocketStompClient
import org.springframework.web.socket.sockjs.client.SockJsClient
import org.springframework.web.socket.sockjs.client.WebSocketTransport
import java.util.concurrent.LinkedBlockingDeque
import java.util.concurrent.TimeUnit

@Service
class SocketService {

    companion object {
        var stompSession: StompSession? = null
    }

    private suspend fun start() {
        if (stompSession != null)
            return

        stompSession = buildSocket("socket:8181/in", 8181)
    }

    suspend fun importOrderProcess(process: Int, max: Int) {
        start()

        stompSession?.send("/send/order/import/process", ImportOrderProcessRequest(
            process, max
        ))
    }

    suspend fun importOrderDone(process: Int, max: Int) {
        start()

        stompSession?.send("/send/order/import/done", ImportOrderProcessRequest(
            process, max
        ))
    }

}

data class ImportOrderProcessRequest(
    val process: Int,
    val max: Int
)