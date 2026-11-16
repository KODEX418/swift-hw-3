//
//  ContentView.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//

import SwiftUI
import SwiftData
enum FilterMode:String, CaseIterable{
    case Watched="Смотрел", All="Все", NotWatched="Не смотрел"
}
enum SortMode:String, CaseIterable{
    case ByName="По имени", ByDate="По году", ByAddDate="По дате добавления", ByRating="По рейтингу"
}
struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Movie.createdAt, order: .reverse) private var movies: [Movie]
    @State private var showAddMovieSheet = false
//    @State private var filterMode: FilterMode = .All
//    @State private var sortMode: SortMode = .ByAddDate
    @State private var sortModeOrderIsAscending = true
    var body: some View {
        NavigationStack{
            List{
                if movies.isEmpty{
                    ContentUnavailableView(
                     "Фильмов пока нет",
                     systemImage: "film",
                     description: Text("Добавьте первый фильм")
                     )
                }
                else{
                    ForEach(movies) { movie in
                        NavigationLink(value:movie){
                            MovieRow(movie: movie)
                        }
                    }
                    .onDelete(perform: deleteMovies)
                }
            }
            .navigationTitle("Мои фильмы")
            .toolbar{
                ToolbarItem{
                    Button("Добавить фильм", systemImage: "plus"){
                        showAddMovieSheet = true
                    }
                }
                
//                ToolbarItem(placement: .bottomBar){
//                    Picker("", selection: $filterMode){
//                        ForEach(FilterMode.allCases, id: \.self){mode in
//                            Text(mode.rawValue).font(.caption).tag(mode)
//                        }
//                    }.pickerStyle(.segmented)
//                }
                
//                ToolbarItem(placement:.topBarLeading){
//                    Menu{
//                    Picker("",selection: $sortMode ){
//                        ForEach(SortMode.allCases, id:\.self) {mode in
//                            Text(mode.rawValue).tag(mode)
//                        }
//                    }
//                        Picker("", selection: $sortModeOrderIsAscending){
//                            Text("По возрастанию").tag(true)
//                            Text("По убыванию").tag(false)
//                        }
//                    } label: {Image(systemName: "arrow.up.arrow.down")}
//                }
                
            }
            
            .sheet(isPresented: $showAddMovieSheet){
                AddMovieView()
            }
            .navigationDestination(for: Movie.self){movie in
                EditMovieView(movie:movie)
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
