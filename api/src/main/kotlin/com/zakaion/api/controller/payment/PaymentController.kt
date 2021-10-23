package com.zakaion.api.controller.payment

import com.google.gson.Gson
import com.zakaion.api.ConstService
import com.zakaion.api.ExFuncs
import com.zakaion.api.controller.BaseController
import com.zakaion.api.dao.BankCardDao
import com.zakaion.api.dao.TransactionInDao
import com.zakaion.api.dao.UserDao
import com.zakaion.api.entity.card.BankCardEntity
import com.zakaion.api.entity.transaction.TransactionInEntity
import com.zakaion.api.exception.BadParams
import com.zakaion.api.exception.NoPermittedMethod
import com.zakaion.api.exception.NotFound
import com.zakaion.api.factor.user.UserFactory
import com.zakaion.api.model.AddCardModel
import com.zakaion.api.model.AddPayModel
import com.zakaion.api.model.DataResponse
import com.zakaion.api.model.OutSumRequestBody
import com.zakaion.api.service.CloudPaymentModel
import com.zakaion.api.service.CloudPaymentService
import com.zakaion.api.service.TransactionService
import org.springframework.core.io.ClassPathResource
import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.util.ResourceUtils
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin(origins = ["*"], maxAge = 3600)
@RequestMapping(value = ["payment"])
class PaymentController(
        private val userDao: UserDao,
        private val transactionService: TransactionService,
        private val userFactory: UserFactory,
        private val transactionInDao: TransactionInDao,
        private val bankCardDao: BankCardDao,
        private val cloudPaymentService: CloudPaymentService,
        private val constService: ConstService
) : BaseController() {

    @GetMapping("/{userID}/balance")
    fun balance(@PathVariable("userID") userID: Long) : DataResponse<Float> {
        return DataResponse.ok(
                transactionService.userBalance(userID)
        )
    }

    @PostMapping("/{userID}/add/pay")
    fun addPay(@PathVariable("userID") userID: Long,
               @RequestBody addPayModel: AddPayModel) : DataResponse<CloudPaymentModel?> {
        val user = userDao.findById(userID).orElseGet {
            throw NotFound()
        }

        val myUser = userFactory.myUser

        val bankCard = bankCardDao.findById(addPayModel.bankCardID).orElseGet {
            throw NotFound()
        }

        if (bankCard.user.id != myUser.id) {
            throw NoPermittedMethod()
        }

        val makePayment = cloudPaymentService.makePayment(
            "${user.firstName} ${user.lastName}",
            "123.455.244.66",
            bankCard.crypto,
            addPayModel.amount.toInt()
        ) ?: return DataResponse(
            success = false,
            data = null,
            error = "cloud payment null"
        )

        println(Gson().toJson(makePayment))

        if (!makePayment.success) {
            /*if (makePayment.model?.acsUrl == null ||
                makePayment.model.paReq == null ||
                makePayment.model.transactionId == null)
                return DataResponse(
                    success = false,
                    data = null,
                    error = "cloud payment model null ${makePayment.model == null}"
                )*/
            return DataResponse.ok(makePayment.model)
        }

        transactionInDao.save(
                TransactionInEntity(
                        amount = addPayModel.amount,
                        user = user,
                        card = bankCard,
                        order = null
                )
        )

        return DataResponse.ok(null)
    }

    @PostMapping("/add/card")
    fun addCard(@RequestBody addCardModel: AddCardModel) : DataResponse<Nothing?> {
        val myUser = userFactory.myUser

        val card = BankCardEntity(
            user = myUser,
            endNum = addCardModel.num,
            crypto = addCardModel.crypto,
            exp = "${addCardModel.expMonth}/${addCardModel.expYear}"
        )

        bankCardDao.save(card)

        return DataResponse.ok(null)
    }

    @GetMapping("/{userID}/card/list")
    fun userCards(pageable: Pageable, @PathVariable("userID") userID: Long) : DataResponse<Page<BankCardEntity>> {
        return DataResponse.ok(
            bankCardDao.userCards(userID, pageable)
        )
    }

    @PostMapping("/{userID}/cloudpayment/3ds/process/{cardID}", produces = [MediaType.TEXT_HTML_VALUE])
    fun processCloudPayment3ds(@RequestParam("MD") transactionId: String,
                                       @RequestParam("PaRes") paRes: String,
                                       @PathVariable("userID") userID: Long,
                                       @PathVariable("cardID") bankCardID: Long): ByteArray {
        val user = userDao.findById(userID).orElseGet {
            throw NotFound()
        }

        val bankCard = bankCardDao.findById(bankCardID).orElseGet {
            throw NotFound()
        }

        val process3ds = cloudPaymentService.process3ds(transactionId, paRes) ?: throw BadParams()

        if (!process3ds.success || process3ds.model?.amount == null)
            return ExFuncs.getResourceFileAsString("templates/fail_payed.html").replace("{{CRM_URL}}", constService.crmUrl).toByteArray()

        transactionInDao.save(
            TransactionInEntity(
                amount = process3ds.model.amount,
                user = user,
                card = bankCard,
                order = null
            )
        )

        return ExFuncs.getResourceFileAsString("templates/success_payed.html").replace("{{CRM_URL}}", constService.crmUrl).toByteArray()
    }

    @PostMapping("/{userID}/cloudpayment/3ds/{cardID}", produces = [MediaType.TEXT_HTML_VALUE])
    fun getWebCloudPayment3ds(
        @PathVariable("userID") userID: Long,
        @RequestParam("transactionId") transactionId: Int,
        @RequestParam("paReq") paReqN: String,
        @RequestParam("acsUrl") acsUrl: String,
        @PathVariable("cardID") bankCardID: Long
    ): ByteArray {

        val paReq = "$paReqN"

        val html = "<html>\n" +
                "\n" +
                "<head>\n" +
                "    <meta charset=\"utf-8\">\n" +
                "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
                "    <meta name=\"description\" content=\"\">\n" +
                "    <meta name=\"author\" content=\"\">\n" +
                "    <title>3D secure</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "\n" +
                "\n" +
                "<form name=\"downloadForm\" action=\"$acsUrl\" method=\"POST\">\n" +
                "    <input type=\"hidden\" name=\"PaReq\" value=\"$paReq\">\n" +
                "    <input type=\"hidden\" name=\"MD\" value=\"$transactionId\">\n" +
                "    <input type=\"hidden\" name=\"TermUrl\" value=\"${constService.apiUrl}/payment/$userID/cloudpayment/3ds/process/$bankCardID\">\n" +
                "</form>\n" +
                "\n" +
                "<script>\n" +
                "    window.onload = submitForm;\n" +
                "    function submitForm() { downloadForm.submit(); }\n" +
                "</script>\n" +
                "</body>\n" +
                "\n" +
                "</html>"

        return html.toByteArray()
    }

    @PostMapping("/out/sum")
    fun outSum(@RequestBody body: OutSumRequestBody): DataResponse<Nothing?> {
        val bankCard = bankCardDao.findById(body.bankCardID).orElseGet {
            throw NotFound()
        }

        val myUser = userFactory.myUser

        if (myUser.id != bankCard.user.id)
            throw NoPermittedMethod()

        val userBalance = transactionService.userBalance(myUser.id)

        if (userBalance < body.amount)
            throw BadParams()

        cloudPaymentService.outSum(
            cardCrypto = bankCard.crypto,
            amount = body.amount,
            userID = myUser.id,
            cardHolderName = "${myUser.firstName} ${myUser.lastName}"
        ).let {
            if (it == null)
                throw BadParams()
            else if (!it.success)
                throw BadParams()
        }

        return DataResponse.ok(null)
    }

    @PostMapping("/on/payment")
    fun onPayment(@RequestBody body: com.fasterxml.jackson.databind.JsonNode): ResponseEntity<Nothing?> {

        println("onPayment body is $body")

        return ResponseEntity.ok(null)
    }

}