//
//  ListRowView.swift
//  ToDoList
//
//  Created by Ivan Maslennikov on 21.06.2024.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title3)
        .padding(.vertical, 8)
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
