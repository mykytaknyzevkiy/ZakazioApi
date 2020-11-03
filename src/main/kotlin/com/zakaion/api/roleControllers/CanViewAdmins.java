package com.zakaion.api.roleControllers;

import com.zakaion.api.entity.user.RoleType;
import org.springframework.security.access.prepost.PreAuthorize;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import static com.zakaion.api.entity.user.RoleTypeKt._ADMIN;
import static com.zakaion.api.entity.user.RoleTypeKt._SUPER_ADMIN;

@Retention(RetentionPolicy.RUNTIME)
@PreAuthorize("hasRole('"+ _SUPER_ADMIN +"')"
        + " || "
        + "hasRole('"+ _ADMIN +"')")
public @interface CanViewAdmins {
}
