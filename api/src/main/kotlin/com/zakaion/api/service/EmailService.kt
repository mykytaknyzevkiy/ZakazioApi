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
        val html: String = htmlTemplate("code_vertification.html")
            .replace("{{CODE}}", code)

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

        val html: String = htmlTemplate("import_done.html")
            .replace("{{IMPORTED}}", (max - brokers.size).toString())
            .replace("{{MAX}}", max.toString())
            .replace("{{ERROR_COUNT}}", brokers.size.toString())
            .replace("{{BROKER_LIST}}", brokersListHtml)

        val mimeMessage = emailSender.createMimeMessage()
        val message = MimeMessageHelper(mimeMessage, true, "UTF-8") // true = multipart
        message.setSubject("Импорт заказов")
        message.setFrom("re_replay@zakazy.online")
        message.setTo(email)
        message.setText(html, true)

        emailSender.send(mimeMessage)
    }

    private fun htmlTemplate(name: String?): String {
        val realName = name ?: "sample_message"

        return ExFuncs.getResourceFileAsString("templates/mail/${realName}")
            .replace("{{BOTTOM_SHEET}}", bottomSheetHtml())
            .replace("{{FILE_STORAGE_URL}}", constService.fileStorageUrl)
    }

    private fun bottomSheetHtml() = ExFuncs.getResourceFileAsString("templates/mail/bottom_sheet.html")
        .replace("{{COMPANY_NAME}}", Contacts.companyName)
        .replace("{{FACEBOOK_URL}}", Contacts.facebook)
        .replace("{{TWITTER_URL}}", Contacts.twitter)
        .replace("{{INSTAGRAM_URL}}", Contacts.instagram)
        .replace("{{LinkedIn_URL}}", Contacts.linkedIn)

}