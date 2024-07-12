//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 09.07.2024.
//

import SwiftUI

struct NoItemsView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var animate: Bool = false
    @State private var showAddNewSheet = false
    let secondaryAccentColor = Color("SecondAccentColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Click the Add button and add a bunch of items to your todo list!")
                    .padding(.bottom, 20)
                Button(action: {
                    showAddNewSheet.toggle()
                }) {
                    Text("Add a task! 🧑🏼‍💻")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
                .shadow(
                    color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0,
                    y: animate ? 50 : 30)
                .sheet(isPresented: $showAddNewSheet) {
                    AddNewTodoView()
                        .environmentObject(listViewModel)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            }
            .multilineTextAlignment(.leading)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
     
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationView {
        NoItemsView()
            .environmentObject(ListViewModel())
            .navigationTitle("title")
    }
}
