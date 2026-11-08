//
//  AddGenreVIew.swift
//  MovieCatalog
//
//  Created by Kostya on 08.11.2026.
//
import SwiftUI

struct AddGenreView:View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State var currentName = ""
    @State var currentColor: Color = .gray
    var body: some View {
        NavigationStack{
            Form{
                TextField("Название", text: $currentName)
                ColorPicker("Цвет", selection: $currentColor)
            }
            .navigationTitle("Новый жанр")
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
        }
    }
    func addGenre() {
        
    }
}
#Preview {
    AddGenreView()
}
