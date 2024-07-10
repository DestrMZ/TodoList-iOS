//
//  ListRowView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

struct ListRowView: View {
    
    let threeAccentColor = Color("ThreeAccentColor")
    @State var opacity: Double = 1.0
    let item: ItemModel
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 16) {
                
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .green : .red)
                
                
                VStack(alignment: .leading, spacing: 4.0) {
                    
                    Text(item.title)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading) 
                }
                    .layoutPriority(1)
                Spacer()
            }
            
        }
        .padding()
        .foregroundColor(.white)
        .background(threeAccentColor) // .opacity(0.8)
//        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(8.0)
        .padding([.horizontal], 5.0)
        .padding(5) // [.bottom]
        .opacity(opacity)
        .frame(maxWidth: .infinity)
        .onAppear {
            withAnimation {
                self.opacity = 1.0
            }
        }
    }
}

var item1 = ItemModel(title: "First item!", isCompleted: false)
var item2 = ItemModel(title: "Second item!", isCompleted: true)

//#Preview("This is the first title", traits: .sizeThatFitsLayout) {
//    ListRowView(item: ItemModel(title: "This is the first item", isCompleted: false))
//}
//
//#Preview("It's second title", traits: .sizeThatFitsLayout) {
//    ListRowView(item: ItemModel(title: "It's second title", isCompleted: true))
//}


#Preview("Main title", traits: .sizeThatFitsLayout) {
    Group {
        ListRowView(item: ItemModel(title: "This is the first title", isCompleted: false))
        ListRowView(item: ItemModel(title: "It's second title", isCompleted: true))
    }
}
