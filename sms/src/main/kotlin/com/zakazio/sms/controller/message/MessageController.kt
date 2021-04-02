package com.zakazio.sms.controller.message

import com.zakazio.sms.DataResponse
import com.zakazio.sms.controller.message.model.MessageRequestModel
import com.zakazio.sms.dao.device.DeviceDao
import com.zakazio.sms.dao.message.MessageDao
import com.zakazio.sms.dao.message.MessageEntity
import com.zakazio.sms.dao.message.MessageStatus
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["message"])
class MessageController(private val messageDao: MessageDao,
                        private val deviceDao: DeviceDao) {

    @PostMapping("/add")
    fun add(@RequestBody body: MessageRequestModel): DataResponse<Nothing?> {
        println("on add message")
        println("phone: ${body.phoneNumber}")
        println("content: ${body.content}")

        messageDao.save(MessageEntity(
            phoneNumber = body.phoneNumber,
            content = body.content
        ))

        return DataResponse.ok(
            null
        )
    }

    @GetMapping("/list")
    fun list(): DataResponse<List<MessageEntity>> {
        return DataResponse.ok(
            messageDao.findAll().toList()
        )
    }

    @GetMapping("/load/{deviceID}")
    fun load(@PathVariable("deviceID") deviceID: Long): DataResponse<MessageEntity?> {
        val device = deviceDao.findById(deviceID).orElseGet {
            throw RuntimeException("Not found")
        }

        if (device.maxSms <= 0)
            return DataResponse.ok(null)

        val messages = messageDao.findAll().filter { it.status == MessageStatus.OPEN }

        if (messages.isEmpty())
            return DataResponse.ok(null)

        val message = messages.random()

        message.apply {
            status = MessageStatus.PROCESS
            worker = device
        }

        messageDao.save(message)

        return DataResponse.ok(
            message.copy(
                content = translit(message.content)
            )
        )
    }

    @PutMapping("/{id}/status/done")
    fun done(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val message = messageDao.findById(id).orElseGet {
            throw RuntimeException("Not found")
        }

        message.status = MessageStatus.DONE

        message.worker?.let {
            it.maxSms = it.maxSms - 1
            deviceDao.save(it)
        }

        messageDao.save(message)

        return DataResponse.ok(null)
    }

    @PutMapping("/{id}/status/error")
    fun error(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val message = messageDao.findById(id).orElseGet {
            throw RuntimeException("Not found")
        }

        message.status = MessageStatus.ERROR

        messageDao.save(message)

        return DataResponse.ok(null)
    }

    fun translit(str: String): String {
        var str: String = str
        val lat_up: Array<String> = arrayOf(
            "A",
            "B",
            "V",
            "G",
            "D",
            "E",
            "Yo",
            "Zh",
            "Z",
            "I",
            "Y",
            "K",
            "L",
            "M",
            "N",
            "O",
            "P",
            "R",
            "S",
            "T",
            "U",
            "F",
            "Kh",
            "Ts",
            "Ch",
            "Sh",
            "Shch",
            "\"",
            "Y",
            "'",
            "E",
            "Yu",
            "Ya"
        )
        val lat_low: Array<String> = arrayOf(
            "a",
            "b",
            "v",
            "g",
            "d",
            "e",
            "yo",
            "zh",
            "z",
            "i",
            "y",
            "k",
            "l",
            "m",
            "n",
            "o",
            "p",
            "r",
            "s",
            "t",
            "u",
            "f",
            "kh",
            "ts",
            "ch",
            "sh",
            "shch",
            "\"",
            "y",
            "'",
            "e",
            "yu",
            "ya"
        )
        val rus_up: Array<String> = arrayOf(
            "А",
            "Б",
            "В",
            "Г",
            "Д",
            "Е",
            "Ё",
            "Ж",
            "З",
            "И",
            "Й",
            "К",
            "Л",
            "М",
            "Н",
            "О",
            "П",
            "Р",
            "С",
            "Т",
            "У",
            "Ф",
            "Х",
            "Ц",
            "Ч",
            "Ш",
            "Щ",
            "Ъ",
            "Ы",
            "Ь",
            "Э",
            "Ю",
            "Я"
        )
        val rus_low: Array<String> = arrayOf(
            "а",
            "б",
            "в",
            "г",
            "д",
            "е",
            "ё",
            "ж",
            "з",
            "и",
            "й",
            "к",
            "л",
            "м",
            "н",
            "о",
            "п",
            "р",
            "с",
            "т",
            "у",
            "ф",
            "х",
            "ц",
            "ч",
            "ш",
            "щ",
            "ъ",
            "ы",
            "ь",
            "э",
            "ю",
            "я"
        )
        for (i in 0..32) {
            str = str.replace(rus_up[i], lat_up[i])
            str = str.replace(rus_low[i], lat_low[i])
        }
        return str
    }
}