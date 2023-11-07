//
//  AllBlogPost.swift
//  PersonalBlog
//
//  Created by dnlab on 11/7/23.
//

import Foundation

struct UserBlogPosts: Codable, Identifiable {
    let id: String
    let posts: [BlogPost]
    let owner: User
}
