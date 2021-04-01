package com.zakazio.sms.dao.message

import org.springframework.data.repository.CrudRepository

interface MessageDao : CrudRepository<MessageEntity, Long>