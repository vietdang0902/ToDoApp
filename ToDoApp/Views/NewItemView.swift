//
//  NewItemView.swift
//  ToDoApp
//
//  Created by VietMac on 10/6/25.
//

import SwiftUI

struct NewItemView: View {
    @StateObject private var viewModel = NewItemViewModel()
    @Binding var newItemPresented: Bool

    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            Form {
                // Title
                TextField("Tittle", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                // Button
                CustomButton(label: "Save",
                             action: {
                                 if viewModel.canSave {
                                     viewModel.save()
                                     newItemPresented = false
                                 } else {
                                     viewModel.showAlert = true
                                 }
                             }
                )
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Please fill in all fields and select due date"))
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {
        true
    }, set: { _ in

    }))
}
