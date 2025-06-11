//
//  ContentView.swift
//  ToDoApp
//
//  Created by VietMac on 10/6/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem {
                    Image(systemName: "house")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    MainView()
}
