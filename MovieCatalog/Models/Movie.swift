//
//  Movie.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//
import Foundation
import SwiftData

@Model
final class Movie {
    var title: String
    var year: Int
    var genre: Genre?
    var isWatched: Bool
    var rating: Int
    var createdAt: Date
    init(title: String, year: Int, genre: Genre? = nil, isWatched: Bool = false, rating: Int = 0, createdAt: Date = .now) {
        self.title = title
        self.year = year
        self.genre = genre
        self.isWatched = isWatched
        self.rating = rating
        self.createdAt = createdAt
    }
}
