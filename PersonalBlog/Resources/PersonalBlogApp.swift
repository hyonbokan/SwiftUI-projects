//
//  PersonalBlogApp.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseCore
import SwiftUI

@main
struct PersonalBlogApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
