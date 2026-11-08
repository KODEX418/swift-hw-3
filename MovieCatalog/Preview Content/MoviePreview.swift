//
//  MoviePreview.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//

import SwiftData
import SwiftUI

@MainActor
let moviePreviewContainer: ModelContainer = {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    do {
        let container = try ModelContainer(for: Movie.self, Genre.self, configurations: configuration)
        
        let animationGenre = Genre(name: "Animation")
        let sciFiGenre = Genre(name: "Science Fiction", color: .cyan)
        
        container.mainContext.insert(Movie(title: "Spirited Away", year: 2001, genre: animationGenre))
        container.mainContext.insert(Movie(title: "Arrival", year: 2016, genre:sciFiGenre, isWatched: true, rating: 5))
        return container
    }
    catch {
        fatalError("Preview container error: \(error)")
    }
}()





