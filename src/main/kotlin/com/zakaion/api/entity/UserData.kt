package com.zakaion.api.entity

import org.hibernate.annotations.GenericGenerator
import javax.persistence.*

@Entity(name = "user")
data class UserEntity(
        @Id
        @GeneratedValue(generator="system-uuid")
        @GenericGenerator(name="system-uuid", strategy = "uuid")
        val id: String = "",
        var email: String,
        var password: String,
        var phoneNumber: String?,
        @Column(name = "first_name")
        var firstName: String,
        @Column(name = "last_name")
        var lastName: String,
        @Column(name = "midle_name")
        var midleName: String,
        @Column(name = "is_user")
        var isUser: Boolean,
        @Column(name = "is_patner")
        var isPartner: Boolean,
        @Column(name = "is_executor")
        var isExecutor: Boolean,
        @Column(name = "is_agent")
        var isAgent: Boolean,
        @Column(name = "is_admin")
        var isAdmin: Boolean,
        @Column(name = "is_super_admin")
        var isSuperAdmin: Boolean,
        @Column(name = "is_editor")
        var isEditor: Boolean,
        @Column(name = "agent_ref_id")
        var agentRefID: String? = null
)

@Entity(name = "passport")
data class UserPassportEntity(
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: String = "",
        @Column(name = "user_id")
        var userID: String,
        var serince: String,
        var number: String
)