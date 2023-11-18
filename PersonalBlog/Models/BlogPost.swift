//
//  BlogPost.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import Foundation

struct BlogPost: Codable, Identifiable {
    let id: String
    let title: String
    let postedDate: String
    let body: String
    var postUrlString: String
    var likers: [String]
    
    var date: Date {
        return DateFormatter.formatter.date(from: postedDate) ?? Date()
    }
    
    var storageReference: String? {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return nil }
        return "\(username)/posts/\(id)"
    }
}

