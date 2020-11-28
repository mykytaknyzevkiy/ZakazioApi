package com.zakaion.api.controller.file

import com.zakaion.api.controller.BaseController
import com.zakaion.api.service.StorageService
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["file"])
class FileController(private val storageService: StorageService) : BaseController() {

    @GetMapping(value = ["/{filename:.+}"], produces = [MediaType.IMAGE_JPEG_VALUE])
    fun file(@PathVariable filename: String): ByteArray {
        val file = storageService.loadAsFile(filename)

        return file.readBytes()
    }

}