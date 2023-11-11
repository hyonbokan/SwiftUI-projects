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
    @Published var currentUser: String = ""
    
    init() {}
    private let database = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
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
    
    public func getUserProfileImageUrl(for username: String, completion: @escaping (URL?) -> Void) {
        storage.child("\(username)/profile_picture.png").downloadURL { url, error in
            completion(url)
        }
    }
}
