package com.zakaion.api.roleControllers;

import org.springframework.security.access.prepost.PreAuthorize;

import static com.zakaion.api.entity.user.RoleTypeKt.*;

@PreAuthorize("hasRole('"+ _SUPER_ADMIN +"')"
        + " || "
        + "hasRole('"+ _ADMIN +"')"
        + " || "
        + "hasRole('"+ _EDITOR +"')")
public @interface CanSuperAdmin_Admin_Editor {
}

