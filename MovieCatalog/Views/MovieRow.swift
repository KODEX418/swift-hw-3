//
//  MovieRow.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//
import SwiftUI
import SwiftData
struct MovieRow: View{
    @Bindable var movie: Movie
    
    var body: some View{
        HStack(spacing:5) {
            Toggle(isOn: $movie.isWatched){
                VStack(alignment: .leading){
                    Text(movie.title)
                        .font(.title2)
                        .strikethrough(movie.isWatched)
                    HStack{
                        if let genre = movie.genre{
                            Text(genre.name)
                                .font(.caption)
                                .foregroundStyle(genre.color)
                        }
                        if let year = movie.year{
                            Text(String(describing: year))
                                .font(.caption)
                        }
                        if movie.rating > 0 {
                            StarView(rating: movie.rating)
                        }
                    }
                }
                
            }
        }
    }
}

struct StarView: View {
    var rating: Int
    var body: some View {
        HStack(spacing:0) {
            ForEach(0..<rating, id: \.self){ _ in
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    @Previewable var m: Movie = Movie(title: "Arrival", year: 2016, genre: Genre(name: "Science Fiction", color: .green), isWatched: true, rating: 5)
    List{
        MovieRow(movie: m)
    }
}
