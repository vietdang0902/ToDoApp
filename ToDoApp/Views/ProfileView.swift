//
//  ProfileView.swift
//  ToDoApp
//
//  Created by VietMac
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            Color.customPinkColor.opacity(0.2)
                .ignoresSafeArea(edges: .all)
            if let user = viewModel.user {
                profileLoginView(user: user)
            } else {
                Text("Loading User..")
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }

    @ViewBuilder
    func profileLoginView(user: TKUser) -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 80, height: 80)
                    .padding(.top, 40)

                Text(user.name)
                    .font(.title)
                    .fontWeight(.semibold)

                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("Date of joining: \(Date(timeIntervalSince1970: user.joined))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()

            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 50)
                    .background(Color.red)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ProfileView()
}
