//
//  SignInViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/14/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class LogInViewViewModel: ObservableObject {
//    @Published var currentUser: User
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    private let database = Firestore.firestore()
    private let auth = Auth.auth()
    
    init() {}
    
    func login() {
        guard validate() else {
            return
        }
        // Try log in
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if result != nil, error == nil {
                print("User logged in")
            } else {
                // show alert true
                self?.showAlert = true
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
    
    public func findUserWithEmail(
        email: String,
        completion: @escaping (User?) -> Void
    ) {
        let ref = database.collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil
            else {
                completion(nil)
                return
            }
            
            let user = users.first(where: { $0.email == email })
            completion(user)
        }
    }
}
