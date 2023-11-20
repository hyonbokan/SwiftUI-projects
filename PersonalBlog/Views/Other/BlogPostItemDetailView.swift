//
//  BlogPostItemDetailView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/8/23.
//

import SwiftUI

struct BlogPostItemDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = BlogPostItemDetailViewModel()
    @State var isLiked: Bool
    
    let model: BlogPost
    let user: User
    let userProfileImage: URL?
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                titleView(title: model.title)
                
                imageView(with: model.postUrlString).padding()
                
                bodyTextView(text: model.body)
                
                userInfoView(imageURL: userProfileImage ?? URL(string: "")!, userName: user.name)
            }
        }
        .navigationTitle(model.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button(action: didTapLike) {
                    Image(systemName: isLiked ? "basketball.fill" : "basketball")
                        .font(.system(size: 15))
                        .foregroundColor(.purple)
                }
                ShareLink(item: model.postUrlString) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 15))
                        .foregroundColor(.purple)
                }
                
                if checkCurrentUser() {
                    Button(action: didTapDelete) {
                        Image(systemName: "trash")
                            .font(.system(size: 15))
                            .foregroundColor(.purple)
                    }
                }
            }
        }
    }
    
    func didTapLike() {
        print("\nIs post liked by the user: \(isLiked)")
        isLiked.toggle()
        viewModel.likePost(state: isLiked ? .like : .unlike , postID: model.id, owner: user.name)
    }
    
    func didTapDelete() {
        viewModel.deletePost(postId: model.id)
        presentationMode.wrappedValue.dismiss()
    }
    
    @ViewBuilder
    func titleView(title: String) -> some View {
        HStack {
            Text(title)
                .bold()
                .font(.title)
                .padding()
            Spacer()
        }
    }
    
    @ViewBuilder
    func imageView(with urlString: String) -> some View {
            let imageSize: CGFloat = UIScreen.main.bounds.width / 1.5
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize)
                        .clipped()
                case .empty, .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        .frame(maxWidth: .infinity, maxHeight: 230, alignment: .center)
    }
    
    @ViewBuilder
    func bodyTextView(text: String) -> some View {
        Text(text)
            .padding()
    }
    
    @ViewBuilder
    func userInfoView(imageURL: URL, userName: String) -> some View {
        HStack {
            NavigationLink {
                ProfileView(username: userName, isCurrentUser: userName == UserDefaults.standard.string(forKey: "username"))
            } label: {
                AsyncImage(url: imageURL) { image in
                    image.image?.resizable()
                }
                .frame(width: 75, height: 75)
                .clipShape(Circle())
            }
            
            Text(userName)
                .bold()
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.horizontal)
    }
    
    func checkCurrentUser() -> Bool {
        guard let currentUser = UserDefaults.standard.string(forKey: "username") else { return false}
        return currentUser == user.name
    }
}
