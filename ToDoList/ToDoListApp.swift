//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
