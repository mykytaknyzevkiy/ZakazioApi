package com.zakaion.api.entity

import org.hibernate.annotations.Type
import javax.persistence.*

@Entity(name = "files")
data class FileEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    val id: Long = 0L,
    @Column(name = "name_n")
    val name: String,
    @Lob
    @Column(columnDefinition="bytea")
    val data: ByteArray
) {

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as FileEntity

        if (id != other.id) return false
        if (!data.contentEquals(other.data)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = id.hashCode()
        result = 31 * result + data.contentHashCode()
        return result
    }

}
