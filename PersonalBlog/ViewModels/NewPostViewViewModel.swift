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
    @Published var image: UIImage?
    @Published var title: String = ""
    @Published var text: String = ""
    
    private let database = Firestore.firestore()

    private let storage = Storage.storage().reference()
    
    public func uploadPost(
        data: Data?,
        id: String,
        completion: @escaping (URL?) -> Void
    ) {
        guard let username = UserDefaults.standard.string(forKey: "username"), let data = data else {
            print("Storage: Could not get username from User Defaults")
            return
        }
        let ref = storage.child("\(username)/posts/\(id).png")
        ref.putData(data, metadata: nil) { _, error in
            ref.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
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
        let storageRef = storage.child("\(username)/posts/\(id).png")
        var postImageUrlString = ""
        if let postImageData = image?.pngData() {
            storageRef.putData(postImageData) { _, _ in
                storageRef.downloadURL { url, error in
                    guard let downloadURL = url else {
                        print("Error getting download URL: \(error?.localizedDescription ?? "unknown error")")
                        return
                    }
                    postImageUrlString = downloadURL.absoluteString
                }
            }
        }
        
        
        let newPost = BlogPost(id: "\(id)", title: title, postedDate: stringDate, body: text, postUrlString: postImageUrlString, likers: [])
        print(newPost)
        
        let dbRef = database.document("users/\(username)/posts/")
    }
}
