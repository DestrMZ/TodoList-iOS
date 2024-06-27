//
//  ListView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListRowView(item: item)
            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo list: 📋") 
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
        
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}

