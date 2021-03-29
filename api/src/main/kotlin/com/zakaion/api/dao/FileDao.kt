package com.zakaion.api.dao

import com.zakaion.api.entity.FileEntity
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import java.util.*

interface FileDao : CrudRepository<FileEntity, Long> {

    @Query("select * from files where name_n = :NAME", nativeQuery = true)
    fun find(@Param("NAME") name: String): Optional<FileEntity>

}