package com.zakaion.api.controller.blog

import com.zakaion.api.controller.blog.model.BlogRequestModel
import com.zakaion.api.dao.BlogDao
import com.zakaion.api.entity.blog.BlogEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.DataResponse
import com.zakaion.api.service.StorageService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@CrossOrigin
@RequestMapping(value = ["blog"])
class BlogController(private val blogDao: BlogDao,
                     private val storageService: StorageService) {

    @GetMapping("/list")
    fun list(pageable: Pageable): DataResponse<Page<BlogEntity>> {
        return DataResponse.ok(
            blogDao.findAll(pageable)
        )
    }

    @PostMapping("/add")
    fun add(@RequestBody body: BlogRequestModel): DataResponse<Nothing?> {
        if (
            body.title.isNullOrEmpty() ||
            body.content.isNullOrEmpty() ||
            body.wallpaper64.isNullOrEmpty())
                throw BadParams()

        blogDao.save(
            BlogEntity(
                title = body.title,
                content = body.content,
                wallpaper = storageService.store(Base64.getDecoder().decode(body.wallpaper64), "jpg")
            )
        )

        return DataResponse.ok(null)
    }

    @GetMapping("/{id}")
    fun info(@PathVariable("id") id: Long): DataResponse<BlogEntity> {
        val blog = blogDao.findById(id).orElseGet {
            throw NotFound()
        }

        return DataResponse.ok(blog)
    }

    @PutMapping("/{id}")
    fun edit(@PathVariable("id") id: Long, @RequestBody body: BlogRequestModel): DataResponse<Nothing?> {
        val blog = blogDao.findById(id).orElseGet {
            throw NotFound()
        }

        blog.apply {
            if (!body.title.isNullOrEmpty())
                this.title = body.title
            if (!body.content.isNullOrEmpty())
                this.content = body.content
            if (!body.wallpaper64.isNullOrEmpty())
                this.wallpaper = storageService.store(Base64.getDecoder().decode(body.wallpaper64), "jpg")
        }

        blogDao.save(blog)

        return DataResponse.ok(null)
    }

    @DeleteMapping("/{id}")
    fun delete(@PathVariable("id") id: Long): DataResponse<Nothing?> {
        val blog = blogDao.findById(id).orElseGet {
            throw NotFound()
        }

        blogDao.delete(blog)

        return DataResponse.ok(null)
    }

}