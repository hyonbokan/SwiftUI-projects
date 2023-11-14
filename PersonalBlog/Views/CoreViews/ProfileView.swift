//
//  ProfileView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                profileHeader(username: "Akagi", profileImageUrl: viewModel.profileImageUrl)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.posts, id: \.id) { post in
                        NavigationLink {
                            BlogPostItemDetailView(isLiked: post.likers.contains("Akagi"), model: post, user: viewModel.user ?? User(name: "None", email: "None"), userProfileImage: viewModel.profileImageUrl)
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
            viewModel.fetchProfileData(username: "Akagi")
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
