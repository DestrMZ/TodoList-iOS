//
//  ListView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var showAddNewSheet: Bool = false
    @State private var showComplete: Bool = true
    @State private var showInComplete: Bool = true
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text(listViewModel.getCurrentData())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 2, y: -20)
            }
            .padding(15)
            
            ZStack {
                if listViewModel.items.isEmpty {
                    NoItemsView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    List {
                        if !listViewModel.incompleteItems.isEmpty {
                            Section(header: Text("Incomplete")) {
                                ForEach(listViewModel.incompleteItems) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                        .listRowInsets(EdgeInsets())
                                        .background(Color.clear)
                                }
                                .onDelete(perform: listViewModel.deleteItem)
                                .onMove(perform: listViewModel.moveItem)
                            }
                        }
                        
                        if !listViewModel.completedItems.isEmpty {
                            Section(header: Text("Completed")) {
                                ForEach(listViewModel.completedItems) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                listViewModel.updateItem(item: item)
                                            }
                                        }
                                        .listRowInsets(EdgeInsets())
                                        .background(Color.clear)
                                }
                                .onDelete(perform: listViewModel.deleteItem)
                                .onMove(perform: listViewModel.moveItem)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("My day")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        showAddNewSheet.toggle()
                    }) {
                        Text("Add")
                    }
            )
            .sheet(isPresented: $showAddNewSheet) {
                AddNewTodoView()
                    .environmentObject(listViewModel)
                    .presentationDetents([.medium, .medium])
            }
        }
    }
}

#Preview {
    NavigationView {
        ListView()
            .environmentObject(ListViewModel())
    }
}

