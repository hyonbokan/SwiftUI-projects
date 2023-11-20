//
//  ProfileView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    let username: String
    let isCurrentUser: Bool
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                profileHeader(username: viewModel.user?.name ?? "Username", profileImageUrl: viewModel.profileImageUrl)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.posts, id: \.id) { post in
                        NavigationLink {
                            BlogPostItemDetailView(isLiked: post.likers.contains(username), model: post, user: viewModel.user ?? User(name: "None", email: "None"), userProfileImage: viewModel.profileImageUrl)
                        } label: {
                            ProfilePostView(viewModel: post)
                        }

                    }
                }
                .padding()
            }
            .navigationTitle("Profile")
            .toolbar {
                if isCurrentUser {
                    Button("Sign Out") {
                        viewModel.signOut()
                    }
                }
            }
            
        }
        .onAppear{
            if isCurrentUser {
                guard let currentUser = UserDefaults.standard.string(forKey: "username") else { return }
                viewModel.fetchProfileData(username: currentUser)
            } else {
                viewModel.fetchProfileData(username: username)
            }
        }
    }
    
    @ViewBuilder
    func profileHeader(username: String, profileImageUrl: URL?) -> some View {
        VStack(alignment: .center) {
            PhotosPicker(selection: $viewModel.selectedItems, maxSelectionCount: 1 ,matching: .images) {
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
                }
                else if let data = viewModel.data, let uiimage = UIImage(data: data) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.purple, lineWidth: 0.5))
                        .padding()
                }
                else {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.purple, lineWidth: 0.5))
                        .padding()
                }
            }.onChange(of: viewModel.selectedItems) {
                [weak viewModel] _ in
                guard let item = viewModel?.selectedItems.first else {
                    return
                }
                item.loadTransferable(type: Data.self) { result in
                   switch result {
                   case .success(let data):
                       if let data = data {
                           DispatchQueue.main.async {
                               viewModel?.data = data
                               viewModel?.profileImageUrl = nil
                               viewModel?.uploadProfileImage()
                           }
                       } else {
                           print("Data is nil")
                       }
                   case .failure(let error):
                       fatalError("\(error)")
                    }
                }
            }
            
            
            Text("\(username)")
                .bold()
        }
    }
}

//#Preview {
//    ProfileView()
//}
