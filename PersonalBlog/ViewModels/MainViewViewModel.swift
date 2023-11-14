//
//  MainViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUser: String = ""
    
    private let auth = Auth.auth()
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUser = user?.uid ?? ""
            }
        })
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
}
