//
//  SignUpViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/15/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class SignUpViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var password2 = ""
    @Published var errorMessage = ""
    
    private let auth = Auth.auth()
    private let database = Firestore.firestore()
    
    init() {}
    
    func register() {
        guard validate() else {
            return
        }
        let newUser = User(name: name, email: email, profileImageUrl: nil)
//        UserDefaults.standard.set(newUser.name, forKey: "username")
//        UserDefaults.standard.set(newUser.email, forKey: "email")
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.errorMessage = "Couldn't register a new user"
                return
            }
            self?.insertUserRecord(username: newUser.name, email: newUser.email)
            let newUsername = UserDefaults.standard.string(forKey: "username") ?? "No user"
            print("\nNew User: \(newUsername)\n")
        }
    }
    
    private func insertUserRecord(username: String, email: String) {
        let newUser = User(name: username, email: email, profileImageUrl: nil)
        guard let data = newUser.asDictionary() else {
            errorMessage = "Couldn't insert user data to the database"
            return
        }
        database.collection("users")
            .document(username)
            .setData(data)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        // trimmingCharacters - trim the space
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in all the fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        guard password.count >= 6 else {
            errorMessage = "Please confirm that your password has 6 or more characters"
            return false
        }
        
        guard password == password2 else {
            errorMessage = "Passwords do not match. Please ensure both passwords are identical."
            return false
        }
        return true
    }
}
