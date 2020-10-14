package com.zakaion.api.controller.app

import com.zakaion.api.Config
import com.zakaion.api.controller.reponse.DataResponse
import com.zakaion.api.dao.PhoneVerificationDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.AppEntity
import com.zakaion.api.entity.PhoneVerificationEntity
import com.zakaion.api.entity.UserEntity
import com.zakaion.api.model.SignUpExecutorModel
import com.zakaion.api.model.SignUpPhoneModel
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import kotlin.random.Random

@CrossOrigin
@RestController
@RequestMapping(value = [Config.appUrl + "/executor"])
class AppExecutorController(
        private val userDao: UserDao,
        private val phoneVerificationDao: PhoneVerificationDao,
        private val partnerAppController: PartnerAppController
) {

    @PostMapping("/signup/phone")
    fun signUpPhone(@RequestHeader(name = Config.appKeyParameterName) apiKey: String,
                    @RequestBody signUpPhoneModel: SignUpPhoneModel): ResponseEntity<DataResponse<String>> {

        val app = partnerAppController.key(apiKey).data as AppEntity

        if (signUpPhoneModel.phone.isEmpty())
            return ResponseEntity(
                    DataResponse(
                            success = false,
                            error = "phone number params is empty",
                            data = "null"
                    ), HttpStatus.BAD_REQUEST)

        if (userDao.findAll().map { it.phoneNumber }.contains(signUpPhoneModel.phone))
            return ResponseEntity(
                    DataResponse(
                            success = false,
                            error = "phone number already taken",
                            data = "null"
                    ), HttpStatus.BAD_REQUEST)

        if (signUpPhoneModel.code == null) {
            //TODO(Send sms code)
            phoneVerificationDao.save(
                    PhoneVerificationEntity(
                            phoneNumber = signUpPhoneModel.phone,
                            code = Random(100).nextInt().toString()
                    )
            )
            return ResponseEntity(
                    DataResponse(
                            success = true,
                            error = null,
                            data = "null"
                    ), HttpStatus.OK)
        }

        val phoneVerification: PhoneVerificationEntity = phoneVerificationDao.findAll().find { it.phoneNumber == signUpPhoneModel.phone }
                ?: return ResponseEntity(
                        DataResponse(
                                success = false,
                                error = "Code is wrong",
                                data = "null"
                        ), HttpStatus.NOT_ACCEPTABLE)



        return ResponseEntity(
                DataResponse(
                        success = true,
                        error = null,
                        data = phoneVerification.id
                ), HttpStatus.OK)
    }

    @PostMapping("/signup")
    fun signUp(@RequestHeader(name = Config.appKeyParameterName) apiKey: String,
               @RequestBody signUpExecutorModel: SignUpExecutorModel): ResponseEntity<DataResponse<Boolean>> {

        val app = partnerAppController.key(apiKey).data as AppEntity

        if (signUpExecutorModel.email.isEmpty() ||
                signUpExecutorModel.firstName.isEmpty() ||
                signUpExecutorModel.lastName.isEmpty() ||
                signUpExecutorModel.middleName.isEmpty() ||
                signUpExecutorModel.password.isEmpty()) {
            return ResponseEntity(
                    DataResponse(
                            success = false,
                            error = "Some params is empty",
                            data = false
                    ), HttpStatus.BAD_REQUEST)
        }

        val phoneVerificationEntity = phoneVerificationDao.findById(signUpExecutorModel.phoneVerificationId)

        if (phoneVerificationEntity.isEmpty)
            return ResponseEntity(
                    DataResponse(
                            success = false,
                            error = "Phone is not allowed more",
                            data = false
                    ), HttpStatus.METHOD_NOT_ALLOWED)

        if (userDao.findAll().filter { it.email == signUpExecutorModel.email }.isNotEmpty()) {
            return ResponseEntity(
                    DataResponse(
                            success = false,
                            error = "Email already taken",
                            data = false
                    ), HttpStatus.METHOD_NOT_ALLOWED)
        }

        val userEntity = UserEntity(
                email = signUpExecutorModel.email,
                password = signUpExecutorModel.password,
                phoneNumber = phoneVerificationEntity.get().phoneNumber,
                isPhoneActive = true,
                firstName = signUpExecutorModel.firstName,
                lastName = signUpExecutorModel.lastName,
                midleName = signUpExecutorModel.middleName,
                isExecutor = true,
                partnerID = app.partner.id
        )

        userDao.save(userEntity)

        phoneVerificationDao.delete(phoneVerificationEntity.get())

        return ResponseEntity(
                DataResponse(
                        success = true,
                        error = null,
                        data = true
                ), HttpStatus.OK)
    }

}