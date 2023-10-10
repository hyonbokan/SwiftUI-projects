//
//  LogInViewModel.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//
import FirebaseAuth
import Foundation

class LogInViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        
        // Try log in
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if result != nil, error == nil {
                print("User logged in")
            } else {
                print("Can't log in")
            }
        }
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        // trimmingCharacters - trim the space
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in all the fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        return true
    }
}