//
//  BlogPostItemDetailViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class BlogPostItemDetailViewModel: ObservableObject {
    
    init() {}
    
    enum LikeState {
        case like, unlike
    }

    func likePost(
        state: LikeState,
        postID: String,
        owner: String
    ) {
        guard let currentUsername = UserDefaults.standard.string(forKey: "username")
        else {
            print("\nCould not access current user\n")
            return
        }
//        let currentUsername = "Akagi"
        let ref = Firestore.firestore()
            .collection("users")
            .document(owner)
            .collection("posts")
            .document(postID)
        
        getPost(with: postID, from: owner) { post in
            guard var post = post else {
                return
            }
            switch state {
            case .like:
                if !post.likers.contains(currentUsername) {
                    post.likers.append(currentUsername)
                    print("\n likers data updated: adding \(currentUsername)")
                }
            case .unlike:
                post.likers.removeAll(where: { $0 == currentUsername })
                print("\n likers data updated: removing \(currentUsername)")
            }
            
            guard let data = post.asDictionary() else {
                return
            }
            ref.setData(data)
            print("The post like state is updated")
        }

    }
    
    public func getPost(
        with id: String,
        from username: String,
        completion: @escaping (BlogPost?) -> Void
    ) {
        let ref = Firestore.firestore()
            .collection("users")
            .document(username)
            .collection("posts")
            .document(id)
        ref.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  error == nil else {
                completion(nil)
                return
            }
            completion(BlogPost(with: data))
        }
    }
    
    public func deletePost(postId: String) {
        guard let currentUsername = UserDefaults.standard.string(forKey: "username") else { return }
        let firebaseRef = Firestore.firestore()
            .collection("users")
            .document(currentUsername)
            .collection("posts")
            .document(postId)
        
        let storageRef = Storage.storage().reference()
            .child("\(currentUsername)/posts/\(postId)")
        
        firebaseRef.delete()
        storageRef.delete { error in
            if let error = error {
                print("the post image is not stored in the storage")
            } else {
                print("post deleted from storage")
            }
        }
    }
}
