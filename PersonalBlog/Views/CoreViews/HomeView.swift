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
    init() {
        self._viewModel = StateObject(wrappedValue: HomeViewViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List(viewModel.userPosts, id: \.id) { userBlogPosts in
                        ForEach(userBlogPosts.posts, id: \.id) { post in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: BlogPostItemDetailView(isLiked: post.likers.contains("Akagi"), model: post, user: userBlogPosts.owner, userProfileImage: userBlogPosts.userProfileImage), label: {
                                    BlogPostItemView(user: userBlogPosts.owner, userImageUrl: userBlogPosts.userProfileImage, item: post)
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
