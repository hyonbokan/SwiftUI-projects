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
           !viewModel.currentUser.isEmpty {
            accountView(currentUser: UserDefaults.standard.string(forKey: "username") ?? "None")
        } else {
            SignInView()
        }
    }
    
    @ViewBuilder
    func accountView(currentUser: String) -> some View {
        TabView {
            HomeView(currentUser: currentUser).tabItem {
                Label("Home", systemImage: "house")
            }
            ProfileView(username: currentUser, isCurrentUser: true).tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .accentColor(.purple)
    }
}

//#Preview {
//    MainView()
//}
