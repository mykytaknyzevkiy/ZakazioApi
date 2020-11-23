package com.zakaion.api.bean

import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.unit.JwtAuthenticationFilter
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource


@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, proxyTargetClass = true)
class SecurityConfig(private val authTokenService: AuthTokenService) : WebSecurityConfigurerAdapter() {

    override fun configure(http: HttpSecurity) {
        /*http
                .cors()
                .and()
                .authorizeRequests()
                .antMatchers("user/login").permitAll()
                .anyRequest()
                .authenticated()
                .and()
                .addFilter(
                        JwtAuthenticationFilter(authTokenService, authenticationManager())
                )
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)*/

        http
                .cors()
                .and()
                .csrf()
                .disable()
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
                .addFilterBefore(JwtAuthenticationFilter(authTokenService, authenticationManager()),
                        UsernamePasswordAuthenticationFilter::class.java)

    }

    /*@Throws(Exception::class)
    override fun configure(auth: AuthenticationManagerBuilder) {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder)
    }*/

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource? {
        val source = UrlBasedCorsConfigurationSource()
        val corsConfiguration = CorsConfiguration().applyPermitDefaultValues()
        source.registerCorsConfiguration("/**", corsConfiguration)
        return source
    }

}