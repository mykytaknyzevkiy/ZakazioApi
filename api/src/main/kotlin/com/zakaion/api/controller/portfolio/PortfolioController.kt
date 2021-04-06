package com.zakaion.api.controller.portfolio

import com.zakaion.api.controller.BaseController
import com.zakaion.api.controller.user.UserController
import com.zakaion.api.dao.PortfolioDao
import com.zakaion.api.entity.executor.PortfolioEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.AddPortfolioModel
import com.zakaion.api.model.DataResponse
import com.zakaion.api.service.StorageService
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["portfolio"])
class PortfolioController(private val portfolioDao: PortfolioDao,
                          private val userController: UserController,
                          private val storageService: StorageService) : BaseController() {

    @GetMapping("/list/user/{userID}")
    fun list(pageable: Pageable, @PathVariable("userID") userID: Long) : DataResponse<Page<PortfolioEntity>> {
        return DataResponse.ok(
                portfolioDao.user(userID, pageable)
        )
    }

    @PostMapping("/add")
    fun add(@RequestBody addPortfolioModel: AddPortfolioModel) : DataResponse<PortfolioEntity> {
        val myUser = userController.get().data

        if (addPortfolioModel.wallpaper.isNullOrEmpty() || addPortfolioModel.label.isNullOrEmpty() || addPortfolioModel.description.isNullOrEmpty())
            throw BadParams()

        val portfolioEntity = PortfolioEntity(
                user = myUser,
                wallpaper = addPortfolioModel.wallpaper,
                label = addPortfolioModel.label,
                description = addPortfolioModel.description,
                imageSlides = (addPortfolioModel.imageSlides ?: emptyList())
        )

        return DataResponse.ok(
                portfolioDao.save(portfolioEntity)
        )
    }

    @GetMapping("/{id}}/info")
    fun info(@PathVariable("id") id: Long): DataResponse<PortfolioEntity> {
        return DataResponse.ok(
            portfolioDao.findById(id).orElseGet {
                throw NotFound()
            }
        )
    }

    @PutMapping("/{id}/update")
    fun update(@RequestBody addPortfolioModel: AddPortfolioModel,
               @PathVariable("id") id: Long) : DataResponse<PortfolioEntity> {
        val myUser = userController.get().data

        val portfolioEntity = portfolioDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (myUser.id != portfolioEntity.user.id
                && myUser.role !in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            throw NoPermittedMethod()

        portfolioEntity.apply {
            if (!addPortfolioModel.wallpaper.isNullOrEmpty()) {
                if (this.wallpaper != addPortfolioModel.wallpaper)
                    storageService.delete(this.wallpaper)

                wallpaper = addPortfolioModel.wallpaper
            }

            if (!addPortfolioModel.label.isNullOrEmpty())
                label = addPortfolioModel.label

            if (!addPortfolioModel.description.isNullOrEmpty())
                description = addPortfolioModel.description

            if (addPortfolioModel.imageSlides != null) {

                imageSlides.forEach {
                    if (!addPortfolioModel.imageSlides.contains(it))
                        storageService.delete(it)
                }

                imageSlides = addPortfolioModel.imageSlides
            }
        }

        return DataResponse.ok(
                portfolioDao.save(portfolioEntity)
        )
    }

    @DeleteMapping("/{id}/delete")
    fun delete(@PathVariable("id") id: Long) : DataResponse<Nothing?> {
        val myUser = userController.get().data

        val portfolioEntity = portfolioDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (myUser.id != portfolioEntity.user.id
                && myUser.role !in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            throw NoPermittedMethod()

        storageService.delete(portfolioEntity.wallpaper)

        portfolioDao.delete(portfolioEntity)

        return DataResponse.ok(null)
    }
}