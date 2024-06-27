//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 27.06.2024.
//

import Foundation


class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []
    
    init() {
        getItem()
    }
    
    func getItem() {
        let newItem = [
            ItemModel(title: "This is first title!", isCompleted: true),
            ItemModel(title: "This is second title!", isCompleted: true),
            ItemModel(title: "It's third  title", isCompleted: false),
        ]
        items.append(contentsOf: newItem)
    }
    
    func deleteItem(IndexSet: IndexSet) {
        items.remove(atOffsets: IndexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
}
