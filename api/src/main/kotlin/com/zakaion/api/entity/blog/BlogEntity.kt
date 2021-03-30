package com.zakaion.api.entity.blog

import java.util.*
import javax.persistence.*

@Entity(name = "blog")
data class BlogEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    var id: Long = 0L,

    @Lob
    @Column(name = "title", length = 1024)
    var title: String,

    @Lob
    @Column(name = "content", length = 1024)
    var content: String,

    var wallpaper: String,

    @Column(name = "creation_date_time", insertable = true, updatable = true/*, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP"*/)
    val creationDateTime: Date = Date(),
)
