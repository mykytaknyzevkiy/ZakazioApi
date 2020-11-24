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
@CrossOrigin
@RequestMapping(value = ["portfolio"])
class PortfolioController(private val portfolioDao: PortfolioDao,
                          private val userController: UserController,
                          private val storageService: StorageService) : BaseController() {

    @GetMapping("/list/my")
    fun list(pageable: Pageable) : DataResponse<Page<PortfolioEntity>> {
        val myUser = userController.get().data

        return DataResponse.ok(
                portfolioDao.user(myUser.id, pageable)
        )
    }

    @PostMapping("/add")
    fun add(@RequestBody addPortfolioModel: AddPortfolioModel) : DataResponse<PortfolioEntity> {
        val myUser = userController.get().data

        if (addPortfolioModel.wallpaper.isEmpty || addPortfolioModel.label.isEmpty || addPortfolioModel.description.isEmpty)
            throw BadParams()

        val portfolioEntity = PortfolioEntity(
                user = myUser,
                wallpaper = storageService.store(Base64.getDecoder().decode(addPortfolioModel.wallpaper), "jpg"),
                label = addPortfolioModel.label,
                description = addPortfolioModel.description
        )

        return DataResponse.ok(
                portfolioDao.save(portfolioEntity)
        )
    }

    @PutMapping("/{id}/update")
    fun update(@RequestBody addPortfolioModel: AddPortfolioModel,
               @PathVariable("id") id: Long) : DataResponse<PortfolioEntity> {
        val myUser = userController.get().data

        if (addPortfolioModel.wallpaper.isEmpty || addPortfolioModel.label.isEmpty || addPortfolioModel.description.isEmpty)
            throw BadParams()

        val portfolioEntity = portfolioDao.findById(id).orElseGet {
            throw NotFound()
        }

        if (myUser.id != portfolioEntity.id
                && myUser.role !in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            throw NoPermittedMethod()

        storageService.delete(portfolioEntity.wallpaper)

        portfolioEntity.apply {
            wallpaper = storageService.store(Base64.getDecoder().decode(addPortfolioModel.wallpaper), "jpg")
            label = addPortfolioModel.label
            description = addPortfolioModel.description
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

        if (myUser.id != portfolioEntity.id
                && myUser.role !in arrayOf(RoleType.SUPER_ADMIN, RoleType.ADMIN, RoleType.EDITOR))
            throw NoPermittedMethod()

        storageService.delete(portfolioEntity.wallpaper)

        portfolioDao.delete(portfolioEntity)

        return DataResponse.ok(null)
    }
}