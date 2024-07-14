//
//  ListRowView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

struct ListRowView: View {
    
    @EnvironmentObject var viewModel: ListViewModel
    
    @State var opacity: Double = 1.0
    @State private var showEditSheet = false
    let item: ItemModel
    let threeAccentColor = Color("ThreeAccentColor")
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 16) {
                

                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .green : .red)
                
                VStack(alignment: .leading, spacing: 4.0) {
                    
                    Text(item.title)
                        .font(.subheadline)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading) 
                    Text("Due: \(item.dueDate)") 
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                        
                }
                    .layoutPriority(1)
                
                Spacer()
                
                Image(systemName: item.isPriority ? "star.fill" : "star")
                    .foregroundColor(item.isPriority ? .yellow : .gray)
                
                
            }
            
        }
        .padding()
        .foregroundColor(.white)
        .background(threeAccentColor)
        .cornerRadius(8.0)
        .padding([.horizontal], 5.0)
        .padding(5)
        .opacity(opacity)
        .frame(maxWidth: .infinity)
        .onAppear {
            withAnimation {
                self.opacity = 1.0
            }
        }
        .contextMenu {
            Button(action: {
                showEditSheet.toggle()
            }) {
                Text("Edit")
                Image(systemName: "pencil")
            }
        }
        .sheet(isPresented: $showEditSheet) {
            EditTodoView(item: item)
                .environmentObject(viewModel)
        }
    }
}

var item1 = ItemModel(title: "First item!", isCompleted: false, dueDate: "2024-07-12", isPriority: true)
var item2 = ItemModel(title: "Second item!", isCompleted: true, dueDate: "2024-07-12", isPriority: false)


#Preview("Main title", traits: .sizeThatFitsLayout) {
    Group {
        ListRowView(item: item1)
        ListRowView(item: item2)
    }
}
