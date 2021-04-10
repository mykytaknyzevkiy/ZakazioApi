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
        if (stompSession?.isConnected == true)
            return

        print("on connect")
        stompSession = buildSocket("socket:8181/in", 8181)
    }

    suspend fun importOrderProcess(uuid: String, process: Int, max: Int, brokers: List<Pair<Int, String>>) {
        start()

        print("Socket msg importOrderProcess $process of $max error:${Gson().toJson(brokers)}")

        try {
            stompSession?.send(
                "/send/order/import/process",
                ImportOrderProcessRequest(
                    process = process,
                    max = max,
                    brokers = emptyList()
                )
            )
        } catch (e: Exception) {
            stompSession = null
            print(e)
        }
    }

}

data class ImportOrderProcessRequest(
    val process: Int,
    val max: Int,
    val brokers: List<ImportOrderProcessBrokeReason>
)

data class ImportOrderProcessBrokeReason(
    val index: Int,
    val reason: String
)