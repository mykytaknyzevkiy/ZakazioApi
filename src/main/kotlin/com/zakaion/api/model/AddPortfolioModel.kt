package com.zakaion.api.model

data class AddPortfolioModel(
        val wallpaper: String?,
        val label: String?,
        val description: String?,
        val imageSlides: List<String>?
)