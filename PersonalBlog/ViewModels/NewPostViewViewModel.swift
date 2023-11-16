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
        guard let stringDate = String.date(from: Date()) else {
            print("Could not convert the date")
            return
        }
        let id = "\(username)_\(randomNumber)_\(timeStamp)"
        // create func for imageUrl
        // create func for save post data
        let storageRef = storage.child("\(username)/posts/\(id).png")
        
        if let postImageData = data {
            storageRef.putData(postImageData) {[weak self] _, _ in
                storageRef.downloadURL { url, error in
                    guard let downloadURL = url else {
                        print("Error getting download URL: \(error?.localizedDescription ?? "unknown error")")
                        return
                    }
//                    postImageUrlString = downloadURL.absoluteString
                    let newPost = BlogPost(id: "\(id)", title: self?.title ?? "", postedDate: stringDate, body: self?.text ?? "", postUrlString: downloadURL.absoluteString, likers: [])
                    print(newPost)
                    let dbRef = self?.database.document("users/\(username)/posts/\(newPost.id)")
                    guard let newPostData = newPost.asDictionary() else {
                        print("Could not encode the post data into dict")
                        return
                    }
                    dbRef?.setData(newPostData)
                    print("New Post Created")
                    
                }
            }
        } else {
            let newPost = BlogPost(id: "\(id)", title: title, postedDate: stringDate, body: text, postUrlString: "", likers: [])
            print(newPost)
            let dbRef = database.document("users/\(username)/posts/\(newPost.id)")
            guard let newPostData = newPost.asDictionary() else {
                print("Could not encode the post data into dict")
                return
            }
            dbRef.setData(newPostData)
            print("New Post Created")
        }

    }
    
    private func createBlogPost(id: String, imageUrl: String) -> BlogPost {
        return BlogPost(id: id,
                        title: title,
                        postedDate: String.date(from: Date()) ?? "",
                        body: text,
                        postUrlString: imageUrl,
                        likers: [])
    }
    
    private func savePost(_ blogPost: BlogPost, username: String) {
        let dbRef = database.document("users/\(username)/posts/\(blogPost.id)")
        guard let blogPostData = blogPost.asDictionary() else {
            print("Could not encode the post data into dict")
            return
        }
        dbRef.setData(blogPostData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("New Post Created")
            }
        }
    }
}
