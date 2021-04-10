package com.zakaion.api.controller.settings

import com.zakaion.api.entity.user._Can_SuperAdmin
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.NotificationPermittedModel
import com.zakaion.api.model.NotificationTemplateSettingsModel
import com.zakaion.api.model.PrimarySettingsModel
import com.zakaion.api.service.EmailNotificationPermitted
import com.zakaion.api.service.PhoneNotificationPermitted
import com.zakaion.api.service.Preference
import com.zakaion.api.service.Templates
import org.springframework.security.access.prepost.PreAuthorize
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin
@RequestMapping(value = ["settings"])
@PreAuthorize(_Can_SuperAdmin)
class SettingsController {

    @GetMapping("/primary")
    fun primary() : DataResponse<PrimarySettingsModel> {
        return DataResponse.ok(
                PrimarySettingsModel(
                        executorMaxOrder = Preference.executorMaxOrder,
                        feedBackUrl = Preference.feedBackUrl,
                        orderSumOutPercent = Preference.orderSumOutPercent,
                        orderPartnerPercent = Preference.orderPartnerPercent,
                        executorPartnerPercent = Preference.executorPartnerPercent
                )
        )
    }

    @PutMapping("/primary")
    fun ediPrimary(@RequestBody primarySettingsModel: PrimarySettingsModel) : DataResponse<Nothing?> {

        if (primarySettingsModel.executorMaxOrder != null)
            Preference.executorMaxOrder = primarySettingsModel.executorMaxOrder

        if (primarySettingsModel.feedBackUrl != null)
            Preference.feedBackUrl = primarySettingsModel.feedBackUrl

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

    @GetMapping("/notification/template")
    fun notificationTemplate() : DataResponse<NotificationTemplateSettingsModel> {
        return DataResponse.ok(
                NotificationTemplateSettingsModel(
                        smsAuth = Templates.smsAuth,
                        createOrder = Templates.createOrder,
                        createOrderViaApp = Templates.createOrderViaApp,
                        youExecutorOrder = Templates.youExecutorOrder,
                        clientHasExecutorOrder = Templates.clientHasExecutorOrder,
                        clientOrderInWork = Templates.clientOrderInWork,
                        addExecutorFeedback = Templates.addExecutorFeedback,
                        addClientFeedback = Templates.addClientFeedback
                )
        )
    }

    @PutMapping("/notification/template")
    fun editNotificationTemplate(@RequestBody bodyEdit: NotificationTemplateSettingsModel) : DataResponse<Nothing?> {

        if (bodyEdit.smsAuth != null)
            Templates.smsAuth = bodyEdit.smsAuth

        if (bodyEdit.createOrder != null)
            Templates.createOrder = bodyEdit.createOrder

        if (bodyEdit.createOrderViaApp != null)
            Templates.createOrderViaApp = bodyEdit.createOrderViaApp

        if (bodyEdit.youExecutorOrder != null)
            Templates.youExecutorOrder = bodyEdit.youExecutorOrder

        if (bodyEdit.clientHasExecutorOrder != null)
            Templates.clientHasExecutorOrder = bodyEdit.clientHasExecutorOrder

        if (bodyEdit.clientOrderInWork != null)
            Templates.clientOrderInWork = bodyEdit.clientOrderInWork

        if (bodyEdit.addExecutorFeedback != null)
            Templates.addExecutorFeedback = bodyEdit.addExecutorFeedback

        if (bodyEdit.addClientFeedback != null)
            Templates.addClientFeedback = bodyEdit.addClientFeedback

        return DataResponse.ok(null)
    }

    @GetMapping("/notification/email/enables")
    fun notificationEmailPermission() : DataResponse<NotificationPermittedModel> {
        return DataResponse.ok(
                NotificationPermittedModel(
                        createOrder = EmailNotificationPermitted.createOrder,
                        youExecutorOrder = EmailNotificationPermitted.youExecutorOrder,
                        clientHasExecutor = EmailNotificationPermitted.clientHasExecutor,
                        clientOrderInWork = EmailNotificationPermitted.clientOrderInWork
                )
        )
    }

    @PutMapping("/notification/email/enables")
    fun editNotificationEmailPermission(@RequestBody bodyEdit: NotificationPermittedModel) : DataResponse<Nothing?> {
        if (bodyEdit.createOrder != null)
            EmailNotificationPermitted.createOrder = bodyEdit.createOrder

        if (bodyEdit.youExecutorOrder != null)
            EmailNotificationPermitted.youExecutorOrder = bodyEdit.youExecutorOrder

        if (bodyEdit.clientHasExecutor != null)
            EmailNotificationPermitted.clientHasExecutor = bodyEdit.clientHasExecutor

        if (bodyEdit.clientOrderInWork != null)
            EmailNotificationPermitted.clientOrderInWork = bodyEdit.clientOrderInWork

        return DataResponse.ok(null)
    }

    @GetMapping("/notification/phone/enables")
    fun notificationPhonePermission() : DataResponse<NotificationPermittedModel> {
        return DataResponse.ok(
                NotificationPermittedModel(
                        createOrder = PhoneNotificationPermitted.createOrder,
                        youExecutorOrder = PhoneNotificationPermitted.youExecutorOrder,
                        clientHasExecutor = PhoneNotificationPermitted.clientHasExecutor,
                        clientOrderInWork = PhoneNotificationPermitted.clientOrderInWork
                )
        )
    }

    @PutMapping("/notification/phone/enables")
    fun editNotificationPhonePermission(@RequestBody bodyEdit: NotificationPermittedModel) : DataResponse<Nothing?> {
        if (bodyEdit.createOrder != null)
            PhoneNotificationPermitted.createOrder = bodyEdit.createOrder

        if (bodyEdit.youExecutorOrder != null)
            PhoneNotificationPermitted.youExecutorOrder = bodyEdit.youExecutorOrder

        if (bodyEdit.clientHasExecutor != null)
            PhoneNotificationPermitted.clientHasExecutor = bodyEdit.clientHasExecutor

        if (bodyEdit.clientOrderInWork != null)
            PhoneNotificationPermitted.clientOrderInWork

        return DataResponse.ok(null)
    }

}