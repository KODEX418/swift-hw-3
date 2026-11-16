//
//  EditGenreView.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//

import SwiftUI
import SwiftData

struct EditGenreView:View {
    @Bindable var genre:Genre
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var deleteConfirmIsVisible = false
    var body: some View {
        NavigationStack{
            Form{
                TextField("Название", text: $genre.name)
                ColorPicker("Цвет", selection: $genre.color)
            }
            .navigationTitle("Изменить жанр")
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button {
                        deleteConfirmIsVisible = true
                    } label: {
                        Text("Удалить").foregroundStyle(.red)
                    }
                }
            }
            .alert("Вы точно хотите удалить?", isPresented: $deleteConfirmIsVisible) {
                Button("Удалить", role: .destructive) {
                    deleteGenre()
                    dismiss()
                }
                Button("Отмена", role: .cancel) {deleteConfirmIsVisible = false}
                
                
            }
        }
    }
    private func deleteGenre(){
        context.delete(genre)
    }
}
#Preview {
    @Previewable var genre = Genre(name: "Sci-fi", color: .cyan)
    EditGenreView(genre: genre)
}
