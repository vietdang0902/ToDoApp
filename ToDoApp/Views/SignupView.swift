//
//  SignupView.swift
//  ToDoApp
//
//  Created by VietMac
//

import SwiftUI

struct SignupView: View {
    
    @StateObject private var viewModel = SignupViewModel()
    
    var body: some View {
        VStack (spacing: 20) {
            VStack (alignment: .leading, spacing: 8) {
                Text("Compelete Your Profile")
                    .font(.system(size: 25, weight: .medium))
                Text("Don't worry only you can see this information (personal data")
            }
            .padding(.top, 20)
            .padding()
            
            VStack {
                CustomTextField (text: $viewModel.name, placeholder: "Name", image: "person")
                
                CustomTextField (text: $viewModel.email, placeholder: "Email", image: "envelope")
                
                CustomTextField(text: $viewModel.password, placeholder: "Password", image: "lock", isSecure: true)
                
                CustomTextField(text: $viewModel.confirmPassword, placeholder: "Confirm Password", image: "lock", isSecure: true)
                
                CustomButton(label: "Signup") {
                    viewModel.register()
                }
            }
            .padding()
        }
    }
}

#Preview {
    SignupView()
}
