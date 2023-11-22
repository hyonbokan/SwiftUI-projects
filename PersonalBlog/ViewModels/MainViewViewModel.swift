//
//  MainViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var currentUser: String = UserDefaults.standard.string(forKey: "username") ?? "User"
    
    private let auth = Auth.auth()
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        print("Main View: \(currentUser)")
        self.handler = Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            DispatchQueue.main.async {
                self?.username = user?.email ?? ""
            }
        })
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
}
