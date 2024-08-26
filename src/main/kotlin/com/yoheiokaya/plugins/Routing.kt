package com.yoheiokaya.plugins

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.http.ContentType

fun Application.configureRouting() {
    routing {
        get("/json") {
            val jsonResponse = """
                    {
                      "message": "Hello, Ktor!",
                      "status": 200
                    }
                """.trimIndent()

            call.respondText(jsonResponse, ContentType.Application.Json)
        }
    }
}
