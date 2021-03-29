package com.zakaion.api.unit

import org.springframework.messaging.converter.MappingJackson2MessageConverter
import org.springframework.messaging.simp.stomp.StompHeaders
import org.springframework.messaging.simp.stomp.StompSession
import org.springframework.messaging.simp.stomp.StompSessionHandlerAdapter
import org.springframework.web.socket.WebSocketHttpHeaders
import org.springframework.web.socket.client.standard.StandardWebSocketClient
import org.springframework.web.socket.messaging.WebSocketStompClient
import org.springframework.web.socket.sockjs.client.SockJsClient
import org.springframework.web.socket.sockjs.client.Transport
import org.springframework.web.socket.sockjs.client.WebSocketTransport
import java.util.ArrayList
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

suspend fun buildSocket(url: String, port: Int): StompSession = suspendCoroutine {cont->
    val transports: MutableList<Transport> = ArrayList()
    transports.add(WebSocketTransport(StandardWebSocketClient()))
    val sockJsClient = SockJsClient(transports)

    val stompClient = WebSocketStompClient(sockJsClient)
    stompClient.messageConverter = MappingJackson2MessageConverter()

    val headers = WebSocketHttpHeaders()

    val handler = object : StompSessionHandlerAdapter() {
        override fun afterConnected(session: StompSession, connectedHeaders: StompHeaders) {
            cont.resume(session)
        }
    }

    stompClient.connect("ws://$url", headers, handler, port)
}