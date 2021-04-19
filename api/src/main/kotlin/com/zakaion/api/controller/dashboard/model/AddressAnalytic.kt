package com.zakaion.api.controller.dashboard.model

import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import com.zakaion.api.entity.user.UserEntity

data class AddressAnalytic(
    val info: RegionEntity,
    val cityList: ArrayList<CityAnalytic> = arrayListOf(),
    override var executors: LinkedHashSet<UserEntity> = linkedSetOf(),
    override var partners: LinkedHashSet<UserEntity> = linkedSetOf(),
    override var orderCount: Int = run {
        var count = 0
        cityList.forEach {
            count += it.orderCount
        }
        count
    },
    override var executorCount: Int = 0,
    override var partnerCount: Int = 0,
    override var orderTotalPrice: Float = 0f,
    override var systemTotalPrice: Float = 0f
): SampleAnalytic(executors, partners, orderCount, executorCount, partnerCount, orderTotalPrice, systemTotalPrice) {

    fun run() {
        executors = run {
            val data = LinkedHashSet<UserEntity>()
            cityList.forEach {
                data.addAll(it.executors)
            }
            data
        }
        partners = run {
            val data = LinkedHashSet<UserEntity>()
            cityList.forEach {
                data.addAll(it.partners)
            }
            data
        }
        orderCount = run {
            var count = 0
            cityList.forEach {
                count += it.orderCount
            }
            count
        }
        executorCount = executors.size
        partnerCount = partners.size
        orderTotalPrice = run {
            var count = 0f
            cityList.forEach {
                count += it.orderTotalPrice
            }
            count
        }
        systemTotalPrice = run {
            var count = 0f
            cityList.forEach {
                count += it.systemTotalPrice
            }
            count
        }
    }

}

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