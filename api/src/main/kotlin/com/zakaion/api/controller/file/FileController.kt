package com.zakaion.api.controller.file

import com.zakaion.api.ExFuncs
import com.zakaion.api.controller.BaseController
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.UploadFileModel
import com.zakaion.api.service.StorageService
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.util.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["file"])
class FileController(private val storageService: StorageService) : BaseController() {

    @GetMapping(value = ["/{filename:.+}"], produces = [MediaType.APPLICATION_OCTET_STREAM_VALUE])
    fun file(@PathVariable filename: String): ByteArray {
        val file = storageService.loadAsFile(filename)

        return file.readBytes()
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

    @GetMapping(value = ["/resource/{filename:.+}"], produces = [MediaType.APPLICATION_OCTET_STREAM_VALUE])
    fun fileResource(@PathVariable filename: String): ByteArray {
        val file = ExFuncs.getResourceFileAsInputStream(filename)

        return file.readBytes()
    }

}