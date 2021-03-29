package com.zakaion.api.roleControllers;

import org.springframework.security.access.prepost.PreAuthorize;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.zakaion.api.entity.user.RoleTypeKt.*;

@Retention(RetentionPolicy.RUNTIME)
@PreAuthorize("hasRole('"+ _SUPER_ADMIN +"')"
        + " || "
        + "hasRole('"+ _ADMIN +"')"
        + " || "
        + "hasRole('"+ _EDITOR +"')"
        + " || "
        + "hasRole('"+ _PARTNER +"')")
public @interface CanSuperAdmin_Admin_Editor_Partner {
}
