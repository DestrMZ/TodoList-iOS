//
//  ItemModel.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 27.06.2024.
//

import Foundation


struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
    
}
