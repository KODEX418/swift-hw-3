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
    @State var movieTitle = ""
    @State var movieYear: Int = Calendar.current.component(.year, from: .now)
    @State var movieGenre: Genre? = nil
    @State var userKnowsYear = false
    @State var showEditGenre = false
    @Query private var existingGenres: [Genre]
    var body: some View {
        NavigationStack{
            Form {
                TextField("Название", text: $movieTitle)
                Toggle(isOn: $userKnowsYear) {
                    HStack {
                        Text("Год:").foregroundStyle(.gray)
                        Stepper(value: $movieYear, in: 1888...2100){
                            TextField("", value: $movieYear, format: .number)
                        }
                        .opacity(userKnowsYear ? 1 : 0)
                        .disabled(!userKnowsYear)
                    }
                }
                HStack{
                    Picker("Жанр", selection: $movieGenre){
                        Text("").tag(nil as Genre?)
                        Divider()
                        ForEach(existingGenres, id: \.self ){genre in
                            Text(genre.name).foregroundStyle(genre.color).tag(genre as Genre?)
                        }
                    }.tint((movieGenre != nil) ? movieGenre?.color : .gray)
                    Divider()
                    Button {
                        showEditGenre = true
                    } label: {
                        Image(systemName: "square.and.pencil")
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
                    Button("Добавить") {}
                }
                
            }
            .sheet(isPresented: $showEditGenre){
                AddGenreView()
                
            }
        }
    }
}
#Preview {
    AddMovieView()
}
