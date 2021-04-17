package com.zakaion.api.controller.settings

import com.zakaion.api.entity.user._Can_SuperAdmin
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.NotificationPermittedModel
import com.zakaion.api.model.PrimarySettingsModel
import com.zakaion.api.model.SettingsContactsModel
import com.zakaion.api.service.Contacts
import com.zakaion.api.service.EmailNotificationPermitted
import com.zakaion.api.service.PhoneNotificationPermitted
import com.zakaion.api.service.Preference
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["settings"])
class SettingsController {

    @GetMapping("/primary")
    fun primary() : DataResponse<PrimarySettingsModel> {
        return DataResponse.ok(
                PrimarySettingsModel(
                        executorMaxOrder = Preference.executorMaxOrder,
                        orderSumOutPercent = Preference.orderSumOutPercent,
                        orderPartnerPercent = Preference.orderPartnerPercent,
                        executorPartnerPercent = Preference.executorPartnerPercent,
                        executorWaitingTimeToStart = Preference.executorWaitingTimeToStart
                )
        )
    }

    @PutMapping("/primary")
    @PreAuthorize(_Can_SuperAdmin)
    fun ediPrimary(@RequestBody primarySettingsModel: PrimarySettingsModel) : DataResponse<Nothing?> {

        if (primarySettingsModel.executorMaxOrder != null)
            Preference.executorMaxOrder = primarySettingsModel.executorMaxOrder

        if (primarySettingsModel.executorWaitingTimeToStart != null)
            Preference.executorWaitingTimeToStart = primarySettingsModel.executorWaitingTimeToStart

        if (primarySettingsModel.orderSumOutPercent != null)
            Preference.orderSumOutPercent = primarySettingsModel.orderSumOutPercent

        if (primarySettingsModel.orderPartnerPercent != null)
            Preference.orderPartnerPercent = primarySettingsModel.orderPartnerPercent

        if (primarySettingsModel.executorPartnerPercent != null)
            Preference.executorPartnerPercent = primarySettingsModel.executorPartnerPercent

        return DataResponse.ok(
                null
        )
    }

    @GetMapping("/notification/email/enables")
    fun notificationEmailPermission() : DataResponse<NotificationPermittedModel> {
        return DataResponse.ok(
                NotificationPermittedModel(
                        createOrder = EmailNotificationPermitted.createOrder,
                        onExecutorInOrder = EmailNotificationPermitted.onExecutorInOrder,
                        onOrderStatus = EmailNotificationPermitted.onOrderStatus
                )
        )
    }

    @PutMapping("/notification/email/enables")
    @PreAuthorize(_Can_SuperAdmin)
    fun editNotificationEmailPermission(@RequestBody bodyEdit: NotificationPermittedModel) : DataResponse<Nothing?> {
        if (bodyEdit.createOrder != null)
            EmailNotificationPermitted.createOrder = bodyEdit.createOrder

        if (bodyEdit.onExecutorInOrder != null)
            EmailNotificationPermitted.onExecutorInOrder = bodyEdit.onExecutorInOrder

        if (bodyEdit.onOrderStatus != null)
            EmailNotificationPermitted.onOrderStatus = bodyEdit.onOrderStatus

        return DataResponse.ok(null)
    }

    @GetMapping("/notification/phone/enables")
    fun notificationPhonePermission() : DataResponse<NotificationPermittedModel> {
        return DataResponse.ok(
                NotificationPermittedModel(
                    createOrder = PhoneNotificationPermitted.createOrder,
                    onExecutorInOrder = PhoneNotificationPermitted.onExecutorInOrder,
                    onOrderStatus = PhoneNotificationPermitted.onOrderStatus
                )
        )
    }

    @PutMapping("/notification/phone/enables")
    @PreAuthorize(_Can_SuperAdmin)
    fun editNotificationPhonePermission(@RequestBody bodyEdit: NotificationPermittedModel) : DataResponse<Nothing?> {
        if (bodyEdit.createOrder != null)
            PhoneNotificationPermitted.createOrder = bodyEdit.createOrder

        if (bodyEdit.onExecutorInOrder != null)
            PhoneNotificationPermitted.onExecutorInOrder = bodyEdit.onExecutorInOrder

        if (bodyEdit.onOrderStatus != null)
            PhoneNotificationPermitted.onOrderStatus = bodyEdit.onOrderStatus

        return DataResponse.ok(null)
    }

    @GetMapping("/contacts")
    fun contacts(): DataResponse<SettingsContactsModel> {
        return DataResponse.ok(
            SettingsContactsModel(
                companyName = Contacts.companyName,
                phoneNumber = Contacts.phoneNumber,
                email = Contacts.email,
                facebook = Contacts.facebook,
                instagram = Contacts.instagram,
                twitter = Contacts.twitter,
                linkedIn = Contacts.linkedIn
            )
        )
    }

    @PutMapping("/contacts")
    @PreAuthorize(_Can_SuperAdmin)
    fun editContacts(@RequestBody body: SettingsContactsModel): DataResponse<Nothing?> {
        if (body.companyName != null) {
            Contacts.companyName = body.companyName
        }
        if (body.phoneNumber != null) {
            Contacts.phoneNumber = body.phoneNumber
        }
        if (body.email != null) {
            Contacts.email = body.email
        }
        if (body.facebook != null) {
            Contacts.facebook = body.facebook
        }
        if (body.instagram != null) {
            Contacts.instagram = body.instagram
        }
        if (body.twitter != null) {
            Contacts.twitter = body.twitter
        }
        if (body.linkedIn != null) {
            Contacts.linkedIn = body.linkedIn
        }

        return DataResponse.ok(
            null
        )
    }

}