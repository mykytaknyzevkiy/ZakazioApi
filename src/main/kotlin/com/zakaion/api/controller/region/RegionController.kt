package com.zakaion.api.controller.region

import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.CityDao
import com.zakaion.api.dao.RegionDao
import com.zakaion.api.entity.executor.PortfolioEntity
import com.zakaion.api.entity.region.CityEntity
import com.zakaion.api.entity.region.RegionEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.CityModel
import com.zakaion.api.model.DataResponse
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["region"])
class RegionController(
        private val regionDao: RegionDao,
        private val cityDao: CityDao
) : BaseController() {

    @GetMapping("/list")
    fun list(pageable: Pageable) : DataResponse<Page<RegionEntity>> {
        return DataResponse.ok(
                regionDao.findAll(pageable)
        )
    }

    @GetMapping("/city/{regionID}/list")
    fun list(pageable: Pageable, @PathVariable("regionID") regionID: Long) : DataResponse<Page<CityEntity>> {
        return DataResponse.ok(
                cityDao.findAll(regionID, pageable)
        )
    }

    @GetMapping("/search")
    fun searchRegions(pageable: Pageable, @RequestParam("query") query: String) : DataResponse<Page<RegionEntity>> {
        return DataResponse.ok(
                regionDao.search(query, pageable)
        )
    }

    @GetMapping("/city/{regionID}/search")
    fun searchRegions(pageable: Pageable,
                      @PathVariable("regionID") regionID: Long,
                      @RequestParam("query") query: String) : DataResponse<Page<CityEntity>> {
        return DataResponse.ok(
                cityDao.search(query, regionID, pageable)
        )
    }

    @PostMapping("/add")
    fun addRegion(@RequestBody cityModel: CityModel) : DataResponse<Nothing?> {
        if (cityModel.name.isEmpty() || cityModel.postCode <= 0)
            throw BadParams()

        regionDao.save(
                RegionEntity(
                        name = cityModel.name,
                        code = cityModel.postCode
                )
        )

        return DataResponse.ok(null)
    }

    @PostMapping("/city/{regionID}/add")
    fun addCity(@RequestBody cityModel: CityModel,
                @PathVariable("regionID") regionID: Long) : DataResponse<Nothing?> {
        if (cityModel.name.isEmpty() || cityModel.postCode <= 0)
            throw BadParams()

        val region = regionDao.findById(regionID).orElseGet {
            throw NotFound()
        }

        cityDao.save(
                CityEntity(
                        name = cityModel.name,
                        code = cityModel.postCode,
                        region = region
                )
        )

        return DataResponse.ok(null)
    }

}