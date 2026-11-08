//
//  Movie.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//
import Foundation
import SwiftData
import SwiftUI

extension Color {
    var rgb: (red: Double, green: Double, blue: Double, alpha: Double) {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b), Double(a))
    }
}

@Model
final class Genre{
    var name: String
    var r: Double
    var g:Double
    var b:Double
    var color: Color{
        return Color(red:r, green:g, blue:b)
    }
    
    @Relationship(deleteRule: .nullify, inverse: \Movie.genre)
    var movies: [Movie]?
    init(name: String, color: Color = .gray) {
        self.name = name
        r = color.rgb.red
        g = color.rgb.green
        b = color.rgb.blue
    }
}


@Model
final class Movie {
    var title: String
    var year: Int?
    var genre: Genre?
    var isWatched: Bool
    var rating: Int
    var createdAt: Date
    init(title: String, year: Int? = nil, genre: Genre? = nil, isWatched: Bool = false, rating: Int = 0, createdAt: Date = .now) {
        self.title = title
        self.year = year
        self.genre = genre
        self.isWatched = isWatched
        self.rating = rating
        self.createdAt = createdAt
    }
}
