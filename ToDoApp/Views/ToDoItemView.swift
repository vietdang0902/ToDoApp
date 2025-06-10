//
//  ToDoItemView.swift
//  ToDoApp
//
//  Created by VietMac
//

import SwiftUI

struct ToDoItemView: View {
    let item: TKToDoItem
    @StateObject private var viewModel = ToDoItemViewModel()
    
    var body: some View {
        HStack {
            Image(systemName: item.isDone ? "checkmark.suqare" : "square")
            
            Text(item.title)
                .font(.title)
                .bold()
            
            Spacer()
            
            Text(viewModel.dueDateString(item: item))
                .font(.footnote)
        }
        .padding(.horizontal, 20)
    }
}

//#Preview {
//    ToDoItemView()
//}
