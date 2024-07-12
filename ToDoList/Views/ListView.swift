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
                Text(listViewModel.getCurrentData()) // Показываем текущую дату
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 2, y: -20)
            }
            .padding(15)
            
            ZStack {
                if listViewModel.items.isEmpty {
                    // Показываем NoItemsView, если задач нет
                    NoItemsView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    List {
                        // Не завершенные задачи
                        if !listViewModel.incompleteItems.isEmpty {
                            Section(header: Text("Incomplete")) {
                                ForEach(listViewModel.incompleteItems) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            // Обновляем задачу при нажатии
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
                        
                        // Завершенные задачи
                        if !listViewModel.completedItems.isEmpty {
                            Section(header: Text("Completed")) {
                                ForEach(listViewModel.completedItems) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            // Обновляем задачу при нажатии
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
            .listStyle(InsetGroupedListStyle()) // Используем стиль с секциями
            .navigationTitle("My day")
            .navigationBarItems(
                leading: EditButton(), // Кнопка редактирования
                trailing:
                    Button(action: {
                        showAddNewSheet.toggle() // Показываем окно добавления новой задачи
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

