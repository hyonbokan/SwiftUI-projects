//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//
import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
