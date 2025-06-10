//
//  ProfileViewModel.swift
//  ToDoApp
//
//  Created by VietMac
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewModel: ObservableObject {
    init() {}

    @Published var user: TKUser? = nil

    func fetchUser() {
        print("Fetching user data")

        guard let userId = Auth.auth().currentUser?.uid else {
            print("No current user!")
            return
        }
        print("User ID: \(userId)")
        let db = Firestore.firestore()

        db.collection("users").document(userId).getDocument { [weak self] data, error in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            }

            guard let userData = data?.data() else {
                print("Document is empty or nil")
                return
            }

            print("User data fetched: \(userData)")

            DispatchQueue.main.async {
                self?.user = TKUser(
                    id: userData["id"] as? String ?? "",
                    name: userData["name"] as? String ?? "",
                    email: userData["email"] as? String ?? "",
                    joined: userData["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Could not sign out")
        }
    }
}
