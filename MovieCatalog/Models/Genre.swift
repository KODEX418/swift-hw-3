//
//  Genre.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//
import SwiftUI
import SwiftData

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
        get {
            return Color(red:r, green:g, blue:b)
        }
        set(newColor){
            r = newColor.rgb.red
            g = newColor.rgb.green
            b = newColor.rgb.blue
        }
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
//extension Genre{
//    static var SF: Genre = Genre(name: "Sci-fi", color: .purple)
//}
