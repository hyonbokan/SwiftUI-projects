//
//  HomeViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseStorage
import FirebaseFirestore
import Foundation

class HomeViewViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var userPosts: [UserBlogPosts] = []
    @Published var isDataFetched = false
    @Published var showingNewPostView = false
    
    private let database = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
    init() {}
    
    public func findUserWithName(
        username: String,
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
            
            let user = users.first(where: { $0.name == username })
            completion(user)
        }
    }
    
    public func findAllUsers(completion: @escaping ([User]) -> Void) {
        let ref = database
            .collection("users")
        ref.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents,
                  error == nil else {
                completion([])
                return
            }
            let users = documents.compactMap { document -> User? in
                return User(with: document.data())
            }
            completion(users)
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
    
    public func getUserProfileImageUrl(for username: String, completion: @escaping (URL?) -> Void) {
        storage.child("\(username)/profile_picture.png").downloadURL { url, error in
            completion(url)
        }
    }
    
    func fetchData() {
//        guard !isDataFetched else {
//            return
//        }
//        isDataFetched = true
        findAllUsers { [weak self] users in
            let group = DispatchGroup()
            for user in users {
                group.enter()
                self?.getPosts(username: user.name) { result in
                    switch result {
                    case .success(let posts):
                        // Get the profile picture URL
                        self?.storage.child("\(user.name)/profile_picture.png").downloadURL { url, error in
                            defer { group.leave() }
                            guard let url = url, error == nil else {
                                print("User profile image is not in the storage")
                                return
                            }
                            DispatchQueue.main.async {
                                let userBlogPosts = UserBlogPosts(id: UUID().uuidString, posts: posts, owner: user, userProfileImage: url)
                                self?.userPosts.append(userBlogPosts)
                            }
                        }
                    case .failure(let error):
                        print(error)
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) { [weak self] in
                self?.userPosts.sort(by: { $0.posts.first?.date ?? Date() > $1.posts.first?.date ?? Date() })
                print("All the user posts have been fetched")
            }
        }
    }
}
