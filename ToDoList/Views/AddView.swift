//
//  AddView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var someColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    @State var alarmTitle: String = ""
    @State var showAlarm: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(someColor))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an Item 🖊️")
        .alert(isPresented: $showAlarm, content: getAlarm)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
         
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
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
        AddView()
    }
    .environmentObject(ListViewModel())

}
