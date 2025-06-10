
//  Created by VietMac
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @State private var isSingup: Bool = false
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Image("login")
                .resizable()
                .frame(width: 200,height: 200)
            
            VStack {
                Text("Login")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                }
                
                CustomTextField (text: $viewModel.email, placeholder: "Email", image: "envelope")
                
                CustomTextField(text: $viewModel.password, placeholder: "Password", image: "lock", isSecure: true)

                CustomButton(label: "Login", action: {
                    viewModel.login()
                })
            }
            .padding()
            
            HStack {
                VStack {Divider()}
                Text("Or")
                VStack {Divider()}
            }
            
            VStack (spacing: 10) {
                CustomButton(label: "Signup with email", iconName: "envelope" ,action: {
                    isSingup.toggle()
                })
                
                CustomButton(label: "Signup with Google", iconImage: Image("google") ,action: {
                    
                })
                
                SignInWithAppleButton(.signIn) {
                    result in
                    
                } onCompletion: { result in
                    
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .signInWithAppleButtonStyle(.whiteOutline)
                .shadow(color: .black, radius: 4, x:0, y:2)
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $isSingup, content: {
            SignupView()
        })
    }
}

#Preview {
    LoginView()
}
