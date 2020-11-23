package com.zakaion.api.bean

import com.zakaion.api.exception.*
import com.zakaion.api.model.DataResponse
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.context.request.WebRequest
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler

@ControllerAdvice
class ThrowResponse : ResponseEntityExceptionHandler() {

    @ExceptionHandler(NoPermittedMethod::class)
    fun handlerNoPermitted(ex: Exception, request: WebRequest): ResponseEntity<DataResponse<Nothing?>> {
        val responseEntity = ResponseEntity(
                DataResponse(
                        success = false,
                        error = "You don`t have permission for this method",
                        data = null
                ),
                HttpStatus.METHOD_NOT_ALLOWED
        )
        return responseEntity
    }

    @ExceptionHandler(NotFound::class)
    fun handlerNotFound(ex: Exception, request: WebRequest): ResponseEntity<DataResponse<Nothing?>> {
        val responseEntity = ResponseEntity(
                DataResponse(
                        success = false,
                        error = "Not found",
                        data = null
                ),
                HttpStatus.NOT_FOUND
        )
        return responseEntity
    }

    @ExceptionHandler(WrongPassword::class)
    fun handlerWrongPassword(ex: Exception, request: WebRequest): ResponseEntity<DataResponse<Nothing?>> {
        val responseEntity = ResponseEntity(
                DataResponse(
                        success = false,
                        error = "Wrong password",
                        data = null
                ),
                HttpStatus.UNAUTHORIZED
        )
        return responseEntity
    }

    @ExceptionHandler(AlreadyTaken::class)
    fun handlerAlreadyTaken(ex: Exception, request: WebRequest): ResponseEntity<DataResponse<Nothing?>> {
        val responseEntity = ResponseEntity(
                DataResponse(
                        success = false,
                        error = "Already taken",
                        data = null
                ),
                HttpStatus.BAD_REQUEST
        )
        return responseEntity
    }

    @ExceptionHandler(BadParams::class)
    fun handlerBadParam(ex: Exception, request: WebRequest): ResponseEntity<DataResponse<Nothing?>> {
        val responseEntity = ResponseEntity(
                DataResponse(
                        success = false,
                        error = "Bad params",
                        data = null
                ),
                HttpStatus.BAD_REQUEST
        )
        return responseEntity
    }

}