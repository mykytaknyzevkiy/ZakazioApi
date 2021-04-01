package com.zakazio.sms.controller.device

import com.zakazio.sms.DataResponse
import com.zakazio.sms.controller.device.model.DeviceInfoRequestModel
import com.zakazio.sms.dao.device.DeviceDao
import com.zakazio.sms.dao.device.DeviceEntity
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["device"])
class DeviceController(private val deviceDao: DeviceDao) {

    @PostMapping("/add")
    fun add(@RequestBody body: DeviceInfoRequestModel): DataResponse<Long> {
        val save = deviceDao.save(
            DeviceEntity(
                name = body.name,
                maxSms = body.maxSms
            )
        )
        return DataResponse.ok(save.id)
    }

    @PutMapping("/{id}")
    fun edit(@PathVariable("id") id: Long,
             @RequestBody body: DeviceInfoRequestModel): DataResponse<Nothing?> {
        val device = deviceDao.findById(id).orElseGet {
            throw RuntimeException("not found")
        }

        device.name = body.name
        device.maxSms = body.maxSms

        deviceDao.save(device)

        return DataResponse.ok(null)
    }

    @GetMapping("/list")
    fun list(): DataResponse<List<DeviceEntity>> {
        return DataResponse.ok(
            deviceDao.findAll().toList()
        )
    }

    @GetMapping("/{id}")
    fun info(@PathVariable("id") id: Long): DataResponse<DeviceEntity> {
        return DataResponse.ok(
            deviceDao.findById(id).orElseGet {
                throw RuntimeException("not found")
            }
        )
    }

}