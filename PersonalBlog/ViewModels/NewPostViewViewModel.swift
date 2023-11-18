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
    
    public func createPost(username: String) {
        let timeStamp = Date().timeIntervalSince1970
        let randomNumber = Int.random(in: 0...1000)
        guard let stringDate = String.date(from: Date())
        else {
            print("Could not convert the date")
            return
        }
        let id = "\(username)_\(randomNumber)_\(timeStamp)"
        let title = self.title
        let text = self.text
        
        var newPost = BlogPost(
            id: id,
            title: title,
            postedDate: stringDate,
            body: text,
            postUrlString: "",
            likers: []
        )
        if let imageData = self.data {
            createImageUrl(username: username, imageData: imageData, userId: id) { url in
                newPost.postUrlString = url.absoluteString
                self.savePost(blogPost: newPost, username: username)
            }
        } else {
            savePost(blogPost: newPost, username: username)
        }
    }
    
    func savePost(blogPost: BlogPost, username: String) {
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
