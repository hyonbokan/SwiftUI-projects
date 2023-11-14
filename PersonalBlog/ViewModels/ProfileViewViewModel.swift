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
    @Published var user: User?
    @Published var posts: [BlogPost] = []
    @Published var profileImageUrl: URL?
    
    init() {}
    private let database = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    
    public func fetchProfileData(username: String) {
        let dispatchGroup = DispatchGroup()
        
        var user: User?
        var profileImageUrl: URL?
        var posts: [BlogPost] = []
        
        dispatchGroup.enter()
        getUserData(username: username) { fetchedUser in
            user = fetchedUser
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getUserProfileImageUrl(username: username) { url in
            profileImageUrl = url
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getPosts(username: username) { fetchedPosts in
            posts = fetchedPosts
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            if let user = user, let url = profileImageUrl {
                self?.user = user
                self?.profileImageUrl = url
                self?.posts = posts
            } else {
                print("An error occurred while fetching profile data.")
            }
        }
    }
    
    public func getUserData(username: String, completion: @escaping (User) -> Void
    ) {
        let ref = database
            .collection("users")
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }), error == nil
            else {
                print("Could not access users collection in the DB")
                return
            }
            guard let user = users.first(where: {$0.name == username }) else {
                print("Could not find \(username) data")
                return
            }
            completion(user)
        }
    }
    
    public func getPosts(
        username: String,
        completion: @escaping ([BlogPost]) -> Void
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
            completion(posts)
        }
    }
    
    public func getUserProfileImageUrl(username: String, completion: @escaping (URL?) -> Void) {
        storage.child("\(username)/profile_picture.png").downloadURL { url, error in
//            guard let profileImageUrl = url else {
//                print("Could get \(username) profile image")
//                return
//            }
            completion(url)
        }
    }
    
    public func signOut() {
        print("sign out")
    }
}
