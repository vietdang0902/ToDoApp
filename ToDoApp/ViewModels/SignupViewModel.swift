//
//  SignupViewModel.swift
//  ToDoApp
//
//  Created by VietMac
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] resul, error in
            guard let userId = resul?.user.uid else {
                return 
            }
            
            self?.createUser(id: userId)
        }
    }
    
    private func createUser(id: String) {
        let newUser = TKUser(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDict())
    }
    
    func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Enter a valid Email/Password. Fill in all the Fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Enter a valid Email"
            return false
        }
        
        guard password.count > 6 else {
            errorMessage = "Password length should be greater than 6"
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords are not matching"
            return false
        }
        
        return true
    }
}
