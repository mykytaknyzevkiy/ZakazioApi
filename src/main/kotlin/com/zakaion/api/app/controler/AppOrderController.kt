package com.zakaion.api.app.controler

import com.zakaion.api.dao.*
import com.zakaion.api.entity.order.OrderEntity
import com.zakaion.api.entity.user.RoleType
import com.zakaion.api.entity.user.UserEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NotFound
import com.zakaion.api.model.AddOrderModel
import com.zakaion.api.model.DataResponse
import com.zakaion.api.service.NotificationService
import com.zakaion.api.app.Const
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = [Const.app_url + "/" + "order"])
class AppOrderController(
    private val orderDao: OrderDao,
    private val userDao: UserDao,
    private val cityDao: CityDao,
    private val categoryDao: CategoryDao,
    private val appDao: AppDao,
    private val notificationService: NotificationService
) {

    @PostMapping("/add")
    fun publish(@PathVariable(Const.app_token_key) appToken: String,
                @RequestBody addOrderModel: AddOrderModel): DataResponse<Nothing?> {
        if (addOrderModel.content.isEmpty() ||
            addOrderModel.dateLine.isEmpty() ||
            addOrderModel.title.isEmpty()
            ||
            addOrderModel.price <= 0)
            throw BadParams()

        if (addOrderModel.clientEmail.isEmpty() ||
                    addOrderModel.clientPhone.isEmpty() ||
                    addOrderModel.clientFirstName.isEmpty() ||
                    addOrderModel.clientLastName.isEmpty() ||
                    addOrderModel.clientMiddleName.isEmpty())
            throw BadParams()

        val app = appDao.find(appToken).orElseGet {
            throw NotFound()
        }

        val partner = userDao.findById(app.masterID).orElseGet {
            throw NotFound()
        }

        val city = cityDao.findById(addOrderModel.cityID).orElseGet {
            throw NotFound()
        }

        val client = userDao.findAll()
            .find { it.phoneNumber == addOrderModel.clientPhone ||
                    it.email == addOrderModel.clientEmail && it.role == RoleType.CLIENT}
            ?: userDao.save(
                UserEntity(
                email = addOrderModel.clientEmail,
                phoneNumber = addOrderModel.clientPhone,
                firstName = addOrderModel.clientFirstName,
                lastName = addOrderModel.clientLastName,
                middleName = addOrderModel.clientMiddleName
            ).apply {
                    this.masterID = partner.id
            })

        val category = categoryDao.findById(addOrderModel.categoryID).orElseGet {
            throw NotFound()
        }

        if (!category.isActive)
            throw BadParams()

        val orderEntity = orderDao.save(
            OrderEntity(
                title = addOrderModel.title,
                content = addOrderModel.content,
                price = addOrderModel.price,
                dateLine = addOrderModel.dateLine,
                client = client,
                executor = null,
                partner = partner,
                city = city,
                files = addOrderModel.files,
                category = category,
                app = app
            )
        )

        notificationService.onCreateOrder(orderEntity)

        return DataResponse.ok(null)
    }

}