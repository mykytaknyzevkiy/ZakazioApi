package com.zakaion.api.bean

import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.unit.JwtAuthenticationFilter
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, proxyTargetClass = true)
class SecurityConfig(private val authTokenService: AuthTokenService) : WebSecurityConfigurerAdapter() {

    override fun configure(http: HttpSecurity) {
        http
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .mvcMatchers(
                        "/user/login",
                        "/user/reset/password",
                        "/executor/register",
                        "/executor/register/phone",
                        "/partner/register",
                        "/partner/register/phone",
                        "/client/register",
                        "/client/register/phone"
                ).permitAll()
                .anyRequest().authenticated()
                .and()
                .addFilterBefore(JwtAuthenticationFilter(authTokenService),
                        UsernamePasswordAuthenticationFilter::class.java)
    }

}