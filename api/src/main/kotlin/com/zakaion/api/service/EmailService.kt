package com.zakaion.api.service

import com.zakaion.api.ConstService
import com.zakaion.api.ExFuncs
import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.mail.javamail.MimeMessageHelper
import org.springframework.stereotype.Service


@Service
class EmailService(private val emailSender: JavaMailSender,
                   private val constService: ConstService) {

    fun sendMsg(email: String, msg: String) {
        val message = SimpleMailMessage()
        message.setFrom("re_replay@zakazy.online")
        message.setTo(email)
        message.setSubject("Zakazy")
        message.setText(msg)
        emailSender.send(message)

    }

    fun sendVerificationCode(email: String, code: String) {
        val html: String = ExFuncs.getResourceFileAsString("templates/mail/code_vertification.html")
            .replace("{{CODE}}", code)
            .replace("{{FILE_STORAGE_URL}}", constService.fileStorageUrl)

        val mimeMessage = emailSender.createMimeMessage()
        val message = MimeMessageHelper(mimeMessage, true, "UTF-8") // true = multipart
        message.setSubject("Подтвердить почту")
        message.setFrom("re_replay@zakazy.online")
        message.setTo(email)
        message.setText(html, true)

        emailSender.send(mimeMessage)
    }

    fun sendImportDone(email: String, max: Int, brokers: List<Pair<Int, String>>) {
        val brokersListHtml = run {
            val html = StringBuilder()
            brokers.forEach {
                html.append("<tr>\n" +
                        "                    <td>${it.first}</td>\n" +
                        "                    <td>${it.second}</td>\n" +
                        "\n" +
                        "                  </tr>")
                html.append("\n")
            }
            html.toString()
        }

        val html: String = ExFuncs.getResourceFileAsString("templates/mail/import_done.html")
            .replace("{{IMPORTED}}", (max - brokers.size).toString())
            .replace("{{MAX}}", max.toString())
            .replace("{{ERROR_COUNT}}", brokers.size.toString())
            .replace("{{BROKER_LIST}}", brokersListHtml)
            .replace("{{FILE_STORAGE_URL}}", constService.apiUrl)

        val mimeMessage = emailSender.createMimeMessage()
        val message = MimeMessageHelper(mimeMessage, true, "UTF-8") // true = multipart
        message.setSubject("Импорт заказов")
        message.setFrom("re_replay@zakazy.online")
        message.setTo(email)
        message.setText(html, true)

        emailSender.send(mimeMessage)
    }

}