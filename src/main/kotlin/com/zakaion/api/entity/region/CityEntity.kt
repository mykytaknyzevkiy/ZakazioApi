package com.zakaion.api.entity.region

import javax.persistence.*

@Entity(name = "city")
data class CityEntity(
        @Id
        @GeneratedValue(strategy= GenerationType.AUTO)
        val id: Long = 0L,
        val name: String,
        val code: Int,
        @OneToOne
        val region: RegionEntity
)