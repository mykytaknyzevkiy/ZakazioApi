package com.zakaion.api.controller.app

import com.zakaion.api.unit.Config
import com.zakaion.api.unit.UnitN
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.controller.reponse.PageResponse
import com.zakaion.api.entity.CategoryEntity
import com.zakaion.api.repository.CategoryRepository
import org.springframework.web.bind.annotation.*

@CrossOrigin
@RestController
@RequestMapping(value = [Config.appUrl + "/category"])
class AppCategoryController(
        private val partnerAppController: PartnerAppController,
        private val categoryRepository: CategoryRepository
) {

    @GetMapping("/list")
    fun list(@RequestHeader(name = Config.appKeyParameterName) apiKey: String,
             @RequestParam(name = "page", required = false, defaultValue = "1") page: Int = 1,
             @RequestParam(name = "size", required = false, defaultValue = "10") size: Int = 10): DataResponse<PageResponse<CategoryEntity>> {
        partnerAppController.key(apiKey)

        return DataResponse(
                data = UnitN.makePaginationResponse(categoryRepository.list().filter { it.active }, pageNo = page, pageSize = size)
        )
    }

}