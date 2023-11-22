//
//  ContentView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn,
           !viewModel.username.isEmpty {
            accountView()
        } else {
            SignInView()
        }
    }
    
    @ViewBuilder
    func accountView() -> some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            ProfileView(username: viewModel.currentUser, isCurrentUser: true).tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .accentColor(.purple)
    }
}

//#Preview {
//    MainView()
//}
