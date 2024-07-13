//
//  AddNewTodoView.swift
//  AddNewTodoView
//
//  Created by Ivan Maslennikov on 12.07.2024.
//


import SwiftUI

struct AddNewTodoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ListViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var todoTitle: String = ""
    @State private var todoDueDate: Date = Date() 
    @State private var todoDueDateString: String = ""
    @State private var alarmTitle: String = ""
    @State private var showAlarm: Bool = false
    
    let update = UINotificationFeedbackGenerator()
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Enter a title", text: $todoTitle, axis: .vertical)
                
                DatePicker("Pick a date", selection: $todoDueDate, displayedComponents: .date)
                    .onChange(of: todoDueDate) {_, newDate in
                        updateDueDateString(from: newDate)
                    }
            }
            .navigationBarTitle("Add an Item 🖊️")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if textIsAppropriate() {
                            update.notificationOccurred(.success)
                            self.dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.viewModel.addItem(title: todoTitle, due_date: todoDueDateString)
                            }
                        }
                    } label: {
                        Text("Add")
                            .bold()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.dismiss()
                    } label: {
                        Text("Close")
                    }
                }
            }
            .onAppear {
                updateDueDateString(from: todoDueDate)
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .alert(isPresented: $showAlarm, content: getAlarm)
    }
    
    func updateDueDateString(from date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_GB")
        todoDueDateString = dateFormatter.string(from: date)
    }
    
    func textIsAppropriate() -> Bool {
        if todoTitle.count < 3 {
            alarmTitle = "Your new todo item must be at least 3 characters long!"
            showAlarm.toggle()
            return false
        }
        return true
    }
    
    func getAlarm() -> Alert {
        return Alert(title: Text(alarmTitle))
    }
}

#Preview {
    NavigationView {
        AddNewTodoView()
            .environmentObject(ListViewModel())
    }
}
