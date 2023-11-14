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
            accountView
        } else {
            SignInView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            ProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .accentColor(.purple)
    }
}

//#Preview {
//    MainView()
//}
