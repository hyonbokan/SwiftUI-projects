//
//  ProfileView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State private var blogPosts: [BlogPost] = []
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        // Create top view for the profile pic and name
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(blogPosts, id: \.id) { post in
                    // Create View for the bottom
                }
            }
            .onAppear{
                viewModel.getPosts(username: "Akagi", completion: { result in
                    switch result {
                    case .success(let posts):
                        self.blogPosts = posts
                        print(posts)
                    case .failure(let error):
                        print(error)
                    }
                })
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
