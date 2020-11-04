package com.zakaion.api.model

data class EditCategoryModel(
        val name: String,
        val isActive: Boolean,
        val image: ByteArray?
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as EditCategoryModel

        if (name != other.name) return false
        if (isActive != other.isActive) return false

        return true
    }

    override fun hashCode(): Int {
        var result = name.hashCode()
        result = 31 * result + isActive.hashCode()
        return result
    }
}