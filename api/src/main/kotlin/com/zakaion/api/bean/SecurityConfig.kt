package com.zakaion.api.bean

import com.zakaion.api.service.AuthTokenService
import com.zakaion.api.unit.JwtAuthenticationFilter
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource


@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
class SecurityConfig(private val authTokenService: AuthTokenService) : WebSecurityConfigurerAdapter() {

    override fun configure(http: HttpSecurity) {
        http
            .headers()
            .frameOptions()
            .disable()
            .and()
                .cors()
                .and()
                .csrf().disable()
                .authorizeRequests().antMatchers(
                        "/user/login",
                        "/user/reset/password",

                        "/executor/register/**",

                        "/partner/register/**",

                        "/client/register/**",

                        "/file/*",

                        "/file/**",

                        "/file",

                        "/order/list/user/*",
                        "/order/list",

                        "/executor/list",
                        "/executor/*",

                        "/category/**",

                        "/app/**",
                        "/region/*",
                        "/region/**",

                        "/payment/**",

                        "/blog/**",

                        "/settings/**",

                        "/portfolio/list/user/*",
                        "/portfolio/*/info"
                ).permitAll()
                .anyRequest()
                .authenticated()
                .and()
                .addFilterBefore(JwtAuthenticationFilter(authTokenService, authenticationManager()),
                        UsernamePasswordAuthenticationFilter::class.java)
    }

    /*@Throws(Exception::class)
    override fun configure(auth: AuthenticationManagerBuilder) {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder)
    }*/

}