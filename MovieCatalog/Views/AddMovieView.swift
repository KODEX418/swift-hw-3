//
//  AddMovieView.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//

import SwiftUI
import SwiftData

struct AddMovieView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var movieTitle = ""
    @State private var movieYear: Int = Calendar.current.component(.year, from: .now)
    @State private var movieRating: Int = 0
    @State private var movieGenre: Genre? = nil
    @State private var showEditGenre = false
    @State private var showAddGenre = false
    @Query private var existingGenres: [Genre]
    var body: some View {
        NavigationStack{
            Form {
                TextField("Название", text: $movieTitle)
                HStack {
                    Text("Год:").foregroundStyle(.gray)
                    Stepper(value: $movieYear, in: 1888...2100){
                        TextField("", value: $movieYear, format: .number)
                    }
                }
                HStack {
                    Text("Рейтинг:").foregroundStyle(.gray)
                    Stepper(value: $movieRating, in: 0...5){
                        TextField("", value: $movieRating, format: .number)
                    }
                }
                HStack{
                    Button {
                        if movieGenre != nil{
                            showEditGenre = true
                        }
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .buttonStyle(.plain)
                    Divider()
                    Picker("Жанр", selection: $movieGenre){
                        Text("").tag(nil as Genre?)
                        Divider()
                        ForEach(existingGenres, id: \.self ){genre in
                            Text(genre.name).foregroundStyle(genre.color).tag(genre as Genre?)
                        }
                    }.tint((movieGenre != nil) ? movieGenre?.color : .gray)
                    Divider()
                    Button {
                        showAddGenre = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Новый фильм")
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить") {
                        addMovie()
                        dismiss()
                    }.disabled(movieTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                
            }
            .sheet(isPresented: $showEditGenre){
                if let movieGenre{
                    EditGenreView(genre: movieGenre)
                }
            }
            .sheet(isPresented: $showAddGenre){
                AddGenreView()
            }
        }
    }
    private func addMovie(){
        context.insert(Movie(title: movieTitle, year: movieYear, genre: movieGenre, rating: movieRating))
    }
}
#Preview {
    AddMovieView()
}
