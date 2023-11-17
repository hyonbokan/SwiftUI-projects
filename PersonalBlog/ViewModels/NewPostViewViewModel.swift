//
//  NewPostViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/16/23.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import _PhotosUI_SwiftUI

class NewPostViewViewModel: ObservableObject {
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var data: Data?
    @Published var title: String = ""
    @Published var text: String = ""
    
    private let database = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
    public func createPost() {
        let timeStamp = Date().timeIntervalSince1970
        let randomNumber = Int.random(in: 0...1000)
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            print("Could not find the user in UserDefaults")
            return
        }
        guard let stringDate = String.date(from: Date())
        else {
            print("Could not convert the date")
            return
        }
        let id = "\(username)_\(randomNumber)_\(timeStamp)"
        let title = self.title
        let text = self.text
//        var urlString = ""
        if let imageData = data {
            createImageUrl(username: username, imageData: imageData, userId: id) { [weak self] url in
//                urlString = url.absoluteString
                let newPost = BlogPost(
                    id: id,
                    title: title,
                    postedDate: stringDate,
                    body: text,
                    postUrlString: url.absoluteString,
                    likers: []
                )
                self?.savePost(newPost, username: username)
            }
//            let newPost = BlogPost(
//                id: id,
//                title: title,
//                postedDate: stringDate,
//                body: text,
//                postUrlString: urlString,
//                likers: []
//            )
//            savePost(newPost, username: username)
        } else {
            let newPost = BlogPost(id: id, title: title, postedDate: stringDate, body: text, postUrlString: "", likers: [])
            savePost(newPost, username: username)
        }
    }
    
    func savePost(_ blogPost: BlogPost, username: String) {
        let dbRef = database.document("users/\(username)/posts/\(blogPost.id)")
        guard let blogPostData = blogPost.asDictionary() else {
            print("Could not encode the post data into dict")
            return
        }
        dbRef.setData(blogPostData) { error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("New Post Created")
            }
        }
    }
    
    func createImageUrl(username: String, imageData: Data, userId: String, completion: @escaping (URL) -> Void
    ) {
        let storageRef = storage.child("\(username)/posts/\(userId).png")
        storageRef.putData(imageData) {_, _ in
            storageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(error?.localizedDescription ?? "unknown error")")
                    return
                }
                completion(downloadURL)
            }
        }
    }
}
