//
//  CustomTextField.swift
//  ToDoApp
//
//  Created by VietMac on 10/6/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var image: String
    var isSecure: Bool = false
    var body: some View {
        HStack {
            Image(systemName: image)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)
    }
}

// #Preview {
//    CustomTextField()
// }
