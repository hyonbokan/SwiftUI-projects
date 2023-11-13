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
        NavigationView {
            ScrollView {
                profileHeader(username: viewModel.currentUser?.name ?? "None", profileImageUrl: viewModel.profileImageUrl)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(blogPosts, id: \.id) { post in
                        NavigationLink {
                            BlogPostItemDetailView(isLiked: false, model: post, user: User(name: "Akagi", email: "Akagi_gori@gmail.com"), userProfileImage: viewModel.profileImageUrl)
                        } label: {
                            ProfilePostView(viewModel: post)
                        }

                    }
                }
                .padding()
            }
            .navigationTitle("Profile")
            .toolbar {
                Button("Sign Out") {
                    viewModel.signOut()
                }
            }
            
        }
        .onAppear{
            viewModel.fetchUserData(username: "Akagi")
            guard let username = viewModel.currentUser?.name else { return }
            viewModel.getPosts(username: username, completion: { result in
                switch result {
                case .success(let posts):
                    self.blogPosts = posts
                    print(posts)
                case .failure(let error):
                    print(error)
                }
            })
            viewModel.getUserProfileImageUrl()
        }
    }
    
    @ViewBuilder
    func profileHeader(username: String, profileImageUrl: URL?) -> some View {
        VStack(alignment: .center) {
            if let imageUrl = profileImageUrl {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.purple, lineWidth: 0.5))
                .padding()
            } else {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.purple, lineWidth: 0.5))
                    .padding()
            }
            Text("\(username)")
                .bold()
        }
    }
}

//#Preview {
//    ProfileView()
//}
