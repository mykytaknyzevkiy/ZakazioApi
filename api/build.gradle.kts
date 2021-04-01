import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
	id("org.springframework.boot") version "2.5.0-SNAPSHOT"
	id("io.spring.dependency-management") version "1.0.11.RELEASE"
	war
	kotlin("jvm") version "1.4.31"
	kotlin("plugin.spring") version "1.4.31"
	kotlin("plugin.jpa") version "1.3.72"
	kotlin("plugin.allopen") version "1.3.61"
}

group = "com.zakaion.api"
version = "2.0.0-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_15

repositories {
	mavenCentral()
	maven { url = uri("https://repo.spring.io/milestone") }
	maven { url = uri("https://repo.spring.io/snapshot") }
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("org.springframework.boot:spring-boot-starter-webflux")
	implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
	implementation("io.projectreactor.kotlin:reactor-kotlin-extensions")
	implementation("org.jetbrains.kotlin:kotlin-reflect")
	implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
	implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor")
	providedRuntime("org.springframework.boot:spring-boot-starter-tomcat")
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-websocket")
	implementation("org.springframework.boot:spring-boot-starter-mail")

	implementation( "mysql:mysql-connector-java:8.0.21")
	runtimeOnly ("mysql:mysql-connector-java")

	implementation("io.jsonwebtoken:jjwt-api:0.11.1")
	providedRuntime("io.jsonwebtoken:jjwt-impl:0.11.1")
	providedRuntime("io.jsonwebtoken:jjwt-jackson:0.11.1")

	implementation("com.google.firebase:firebase-server-sdk:3.0.1")

	implementation("eu.bitwalker:UserAgentUtils:1.21")

	implementation("org.apache.poi:poi:3.15")
	implementation("org.apache.poi:poi-ooxml:3.15")

	implementation("org.thymeleaf:thymeleaf:3.0.11.RELEASE")
}

tasks.withType<KotlinCompile> {
	kotlinOptions {
		freeCompilerArgs = listOf("-Xjsr305=strict")
		jvmTarget = "15"
	}
}

tasks.withType<Test> {
	useJUnitPlatform()
}
