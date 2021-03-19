package com.zakaion.api.entity.order.category

import javax.persistence.*

@Entity(name = "category_child")
data class ChildCategoryEntity(
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    val id: Long = 0L,

    @OneToOne
    val parent: CategoryEntity,

    val name: String
)
