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
        NavigationView {
            ZStack {
                if let user = viewModel.user {
                    profileLoginView(user: user)
                } else {
                    Text("Loading User..")
                }
            }
            .onAppear {
                viewModel.fetchUser()
            }
            .navigationTitle("Profile")
        }
    }

    @ViewBuilder
    func profileLoginView(user: TKUser) -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 80, height: 80)
                    .padding(.top, 20)

                VStack(alignment: .leading) {
                    HStack {
                        Text("Name: ")
                            .bold()
                        Text(user.name)
                            .font(.title2)
                    }
                    .padding()

                    HStack {
                        Text("Email: ")
                            .bold()
                        Text(user.email)
                            .font(.title3)
                    }
                    .padding()

                    HStack(alignment: .top) {
                        Text("Member since: ")
                            .bold()
                        Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                            .font(.title3)
                    }
                    .padding()
                }
            }

            Spacer()

            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ProfileView()
}
