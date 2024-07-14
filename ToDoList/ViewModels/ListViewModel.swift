//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 27.06.2024.
//

import Foundation


class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init() {
        getItem()
    }
    
    func getItem() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(IndexSet: IndexSet) {
        items.remove(atOffsets: IndexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, due_date: String) {
        let newItem = ItemModel(title: title, isCompleted: false, dueDate: due_date, isPriority: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: { (existingItem) -> Bool in
            return existingItem.id == item.id
        }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func priorityItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: { (priorityItem) -> Bool in
            return priorityItem.id == item.id
        }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func updateExistingItem(item: ItemModel, title: String, dueDate: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = ItemModel(id: item.id, title: title, isCompleted: item.isCompleted, dueDate: dueDate, isPriority: item.isPriority)
        }
    }
    
    func getCurrentData() -> String {
        let date = Date()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "EEEE, d MMMM"
        return dataFormatter.string(from: date)
    }
    
    var incompleteItems: [ItemModel] {
        items.filter { !$0.isCompleted }
    }
    
    var completedItems: [ItemModel] {
        items.filter { $0.isCompleted }
    }
}



