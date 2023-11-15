//
//  SignInViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/14/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class SignInViewViewModel: ObservableObject {
    @Published var currentUser: String = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    private let database = Firestore.firestore()
    private let auth = Auth.auth()
    
    init() {}
    
//    func login() {
//        guard validate() else {
//            return
//        }
//        // Try log in
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
//            if result != nil, error == nil {
//                print("User logged in")
//            } else {
//                // show alert true
//                self?.showAlert = true
//                print("Can't log in")
//                
//            }
//        }
//    }
    func login() {
            guard validate() else {
                showAlert = true
                return
            }
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let strongSelf = self else { return }
                if result != nil, error == nil {
                    strongSelf.findUserWithEmail(email: strongSelf.email) { user in
                        if let user = user {
                            // Store email and username in cache
                            UserDefaults.standard.set(user.email, forKey: "email")
                            UserDefaults.standard.set(user.name, forKey: "username")
                            DispatchQueue.main.async {
                                strongSelf.currentUser = user.name
                            }
                            print("User logged in and user data stored in cache")
                        } else {
                            print("User logged in but user data could not be found in database")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.showAlert = true
                    }
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
