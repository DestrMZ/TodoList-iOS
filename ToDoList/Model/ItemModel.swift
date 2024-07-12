//
//  ItemModel.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 27.06.2024.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    var dueDate: String
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, dueDate: String) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, dueDate: dueDate)
    }
}
