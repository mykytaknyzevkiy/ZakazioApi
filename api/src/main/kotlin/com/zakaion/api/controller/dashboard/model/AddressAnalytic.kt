package com.zakaion.api.controller.dashboard.model

import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import com.zakaion.api.entity.user.UserEntity

data class AddressAnalytic(
    val info: RegionEntity,
    val cityList: ArrayList<CityAnalytic> = arrayListOf(),
    override val executors: LinkedHashSet<UserEntity> = run {
        val data = LinkedHashSet<UserEntity>()
        cityList.forEach {
            data.addAll(it.executors)
        }
        data
    },
    override val partners: LinkedHashSet<UserEntity> = run {
        val data = LinkedHashSet<UserEntity>()
        cityList.forEach {
            data.addAll(it.partners)
        }
        data
    },
    override var orderCount: Int = 0,
    override var executorCount: Int = executors.size,
    override var partnerCount: Int = partners.size,
    override var orderTotalPrice: Float = 0f,
    override var systemTotalPrice: Float = 0f,
): SampleAnalytic(executors, partners, orderCount, executorCount, partnerCount, orderTotalPrice, systemTotalPrice)

data class CityAnalytic(
    val info: CityEntity,
    override val executors: LinkedHashSet<UserEntity> = LinkedHashSet(),
    override val partners: LinkedHashSet<UserEntity> = LinkedHashSet(),
    override var orderCount: Int = 0,
    override var executorCount: Int = 0,
    override var partnerCount: Int = 0,
    override var orderTotalPrice: Float = 0f,
    override var systemTotalPrice: Float = 0f,
): SampleAnalytic(executors, partners, orderCount, executorCount, partnerCount, orderTotalPrice, systemTotalPrice)