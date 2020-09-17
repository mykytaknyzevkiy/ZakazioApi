package com.zakaion.api.controller

import com.zakaion.api.Config
import com.zakaion.api.repository.StorageService
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile

@CrossOrigin
@RestController
@RequestMapping(value = [Config.genUrl + "/files"])
class FilesController(private val storageService: StorageService) {

    @PostMapping("/save")
    fun save(@RequestParam("file") file: MultipartFile): String {
        System.out.println()
        return storageService.store(file)
    }

    @PostMapping("/list")
    fun save(): List<String> {
        return storageService.list()
    }

    @GetMapping("/{filename:.+}")
    fun file(@PathVariable filename: String): ResponseEntity<Resource> {
        val resource = storageService.loadAsResource(filename)

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + resource.filename + "\"")
                .body(resource)
    }

    @DeleteMapping("/{filename:.+}")
    fun delete(@PathVariable filename: String): Boolean {
        return storageService.delete(filename)
    }

}