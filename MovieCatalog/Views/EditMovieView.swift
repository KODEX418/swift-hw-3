//
//  EditMovieView.swift
//  MovieCatalog
//
//  Created by Kostya on 10.11.2026.
//
import SwiftUI
import SwiftData

struct EditMovieView:View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable var movie:Movie
    @State private var showEditGenre = false
    @State private var showAddGenre = false
    @Query private var existingGenres: [Genre]
    var body: some View {
        Form {
            TextField("Название", text: $movie.title)
                HStack {
                    Text("Год:").foregroundStyle(.gray)
                    Stepper(value: $movie.year, in: 1888...2100){
                        TextField("", value: $movie.year, format: .number)
                    }
                }
            HStack {
                Text("Рейтинг:").foregroundStyle(.gray)
                Stepper(value: $movie.rating, in: 0...5){
                    TextField("", value: $movie.rating, format: .number)
                }
            }
            HStack{
                Button {
                    if movie.genre != nil{
                        showEditGenre = true
                    }
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                .buttonStyle(.plain)
                Divider()
                Picker("Жанр", selection: $movie.genre){
                    Text("").tag(nil as Genre?)
                    Divider()
                    ForEach(existingGenres, id: \.self ){genre in
                        Text(genre.name).foregroundStyle(genre.color).tag(genre as Genre?)
                    }
                }.tint((movie.genre != nil) ? movie.genre?.color : .gray)
                Divider()
                Button {
                    showAddGenre = true
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("Изменить фильм")
        .sheet(isPresented: $showEditGenre) {
            if let genre = movie.genre {
                EditGenreView(genre: genre)
            }
        }
        .sheet(isPresented: $showAddGenre){
            AddGenreView()
        }
    }
}

#Preview {
    @Previewable var m: Movie = Movie(title: "Arrival",year:1968, genre: Genre(name: "Science Fiction", color: .green), isWatched: true, rating: 5)
    EditMovieView(movie: m)
}
