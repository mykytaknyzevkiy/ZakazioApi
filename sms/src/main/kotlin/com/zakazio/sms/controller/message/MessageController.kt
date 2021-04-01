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
            message
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
}