package com.zakaion.api.app.controler

import com.zakaion.api.controller.BaseController
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.UploadFileModel
import com.zakaion.api.service.StorageService
import com.zakaion.api.app.Const
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = [Const.app_url + "/" +"file"])
class AppFileController(private val storageService: StorageService) : BaseController() {

    @GetMapping(value = ["/{filename:.+}"], produces = [MediaType.APPLICATION_OCTET_STREAM_VALUE])
    fun file(@PathVariable filename: String): ByteArray {
        return storageService.loadAsBytes(filename)
    }

    @PostMapping("/add")
    fun add(@RequestParam("file") file: MultipartFile) : String {
        return storageService.store(file)
    }

    @PostMapping("/add/byte")
    fun add(@RequestBody body : UploadFileModel) : DataResponse<String> {
        return DataResponse.ok(
            storageService.store(Base64.getDecoder().decode(body.file), body.format)
        )
    }

}