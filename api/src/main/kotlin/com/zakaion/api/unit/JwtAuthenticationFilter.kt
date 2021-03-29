package com.zakaion.api.unit

import com.zakaion.api.service.AuthTokenService
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter
import org.springframework.web.filter.OncePerRequestFilter
import javax.servlet.FilterChain
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class JwtAuthenticationFilter(private val tokenService: AuthTokenService, authenticationManager: AuthenticationManager?) : BasicAuthenticationFilter(authenticationManager) {

    override fun doFilterInternal(request: HttpServletRequest,
                                  response: HttpServletResponse,
                                  filterChain: FilterChain) {

        val authorizationHeader: String? = request.getHeader("Authorization")

        if (authorizationHeader == null) {
            filterChain.doFilter(request, response)
            return
        }

        val user = tokenService.parseToken(authorizationHeader.replace("Bearer ", ""))

        if (user == null) {
            filterChain.doFilter(request, response)
            return
        }

        val grantees = arrayListOf<GrantedAuthority>(SimpleGrantedAuthority(user.role.data))

        val userPasswordToken = UsernamePasswordAuthenticationToken(user, null, grantees)

        SecurityContextHolder.getContext().authentication = userPasswordToken
        filterChain.doFilter(request, response)
    }
}