package com.zakaion.api.entity.user

enum class RoleType(val data: String) {
    SUPER_ADMIN(_SUPER_ADMIN),
    ADMIN(_ADMIN),
    EDITOR(_EDITOR),
    EXECUTOR(_EXECUTOR),
    PARTNER(_PARTNER),
    AGENT(_AGENT),
    CLIENT(_CLIENT)
}

const val _SUPER_ADMIN = "SUPER_ADMIN"

const val _ADMIN = "ADMIN"

const val _EDITOR = "EDITOR"

const val _EXECUTOR = "EXECUTOR"

const val _PARTNER = "PARTNER"

const val _AGENT = "AGENT"

const val _CLIENT = "CLIENT"

const val _Can_SuperAdmin = "hasAuthority('$_SUPER_ADMIN')"
const val _Can_SuperAdmin_Admin_Editor = "hasAuthority('$_SUPER_ADMIN') || hasAuthority('$_ADMIN') || hasAuthority('$_EDITOR')"
const val _Can_SuperAdmin_Admin_Editor_Partner = "hasAuthority('$_SUPER_ADMIN') || hasAuthority('$_ADMIN') || hasAuthority('$_EDITOR') || hasAuthority('$_PARTNER')"