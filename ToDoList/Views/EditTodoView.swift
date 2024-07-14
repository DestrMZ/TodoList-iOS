//
//  EditTodoView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 13.07.2024.
//

import SwiftUI

struct EditTodoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ListViewModel
    
    @State private var todoTitle: String
    @State private var todoDueDate: Date
    @State private var todoDueDateString: String
    let item: ItemModel
    
    init(item: ItemModel) {
        self.item = item
        _todoTitle = State(initialValue: item.title)
        _todoDueDate = State(initialValue: DateFormatter().date(from: item.dueDate) ?? Date())
        _todoDueDateString = State(initialValue: item.dueDate)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter a title", text: $todoTitle, axis: .vertical)
                
                DatePicker("Completion date", selection: $todoDueDate, displayedComponents: .date)
                    .onChange(of: todoDueDate) {_, newDate in
                        updateDueDateString(from: newDate)
                    }
            }
            .navigationBarTitle("Edit Item 🖊️")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        viewModel.updateExistingItem(item: item, title: todoTitle, dueDate: todoDueDateString)
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .bold()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
        .onAppear {
            updateDueDateString(from: todoDueDate)
        }
    }
    
    func updateDueDateString(from date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_GB")
        todoDueDateString = dateFormatter.string(from: date)
    }
}

#Preview {
    EditTodoView(item: ItemModel(title: "Example task", isCompleted: false, dueDate: "2024-07-12", isPriority: false))
        .environmentObject(ListViewModel())
}
