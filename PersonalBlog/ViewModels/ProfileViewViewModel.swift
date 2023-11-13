//
//  ProfileViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/9/23.
//
import FirebaseStorage
import FirebaseFirestore
import Foundation

class ProfileViewViewModel : ObservableObject {
    @Published var currentUser: User? = nil
    @Published var profileImageUrl: URL?
    
    init() {}
    private let database = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    
    public func fetchUserData(username: String) {
        let ref = database
            .collection("users")
        ref.getDocuments { [weak self] snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil
            else {
                print("Could not find \(username) data")
                return
            }
            let user = users.first(where: {$0.name == username })
            self?.currentUser = user
        }
    }
    
    public func getPosts(
        username: String,
        completion: @escaping (Result<[BlogPost], Error>) -> Void
    ) {
        let ref = database
            .collection("users")
            .document(username)
            .collection("posts")
        
        ref.getDocuments { snapshot, error in
            guard let posts = snapshot?.documents.compactMap({
                BlogPost(with: $0.data()
                )}).sorted(by: { return $0.date > $1.date
                }),
                  error == nil else {
                return
            }
            completion(.success(posts))
        }
    }
    
    public func getUserProfileImageUrl() {
        guard let username = self.currentUser?.name else {
            print("Current user is not found")
            return
        }
        storage.child("\(username)/profile_picture.png").downloadURL { [weak self] url, error in
            DispatchQueue.main.async {
                self?.profileImageUrl = url
            }
        }
    }
    
    public func signOut() {
        print("sign out")
    }
}
