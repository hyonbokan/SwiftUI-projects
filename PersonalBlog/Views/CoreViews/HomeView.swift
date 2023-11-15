//
//  HomeView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewViewModel
    let currentUser: String
    
    init(currentUser: String) {
        self._viewModel = StateObject(wrappedValue: HomeViewViewModel())
        self.currentUser = currentUser
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List(viewModel.userPosts, id: \.id) { userBlogPosts in
                        ForEach(userBlogPosts.posts, id: \.id) { post in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: BlogPostItemDetailView(isLiked: post.likers.contains(currentUser), model: post, user: userBlogPosts.owner, userProfileImage: userBlogPosts.userProfileImage), label: {
                                    BlogPostItemView(user: userBlogPosts.owner, userImageUrl: userBlogPosts.userProfileImage, item: post, isLiked: post.likers.contains(currentUser))
                                })

                            }
                        }
                }
            }.onAppear {
                if !viewModel.isDataFetched {
                    viewModel.fetchData()
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentUser: "Akagi")
    }
}
