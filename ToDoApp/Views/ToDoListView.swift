 //
//  ToDoView.swift
//  ToDoApp
//
//  Created by VietMac on 10/6/25.
//

import SwiftUI
import FirebaseAuth

struct ToDoListView: View {
    
    @StateObject var viewModel = ToDoListViewModel()
    
    private let userId: String
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}
//
//#Preview {
//    ToDoView()
//}
