//
//  ContentView.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var movies: [Movie]
    @State var showAddMovieSheet = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(movies) { movie in
                    MovieRow(movie: movie)
                }
                .onDelete(perform: deleteMovies)
            }
            .navigationTitle("Мои фильмы")
            .toolbar{
                ToolbarItem{
                    Button("Добавить фильм", systemImage: "plus"){
                        showAddMovieSheet = true
                    }
                }
            }
            .sheet(isPresented: $showAddMovieSheet){
                
            }
        }
        
        
    }
    private func deleteMovies(at offsets: IndexSet){
        for index in offsets{
            context.delete(movies[index])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(moviePreviewContainer)
}
