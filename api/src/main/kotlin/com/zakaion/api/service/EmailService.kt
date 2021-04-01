package com.zakaion.api.service

import org.springframework.mail.javamail.JavaMailSender
import org.springframework.stereotype.Service
import org.springframework.mail.SimpleMailMessage

@Service
class EmailService(private val emailSender: JavaMailSender) {

    fun sendMsg(email: String, msg: String) {
        println("on send email")
        val message = SimpleMailMessage()
        message.setFrom("re_replay@zakazy.online")
        message.setTo(email)
        message.setSubject("Zakazy")
        message.setText(msg)
        emailSender.send(message)
        println("sent email")

    }

}