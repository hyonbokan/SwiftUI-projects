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
    @State var isLiked = false
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
                                NavigationLink(destination: BlogPostItemDetailView(isLiked: post.likers.contains(currentUser), model: post, user: userBlogPosts.owner, userProfileImage: userBlogPosts.userProfileImage)) {
                                    BlogPostItemView(user: userBlogPosts.owner, userImageUrl: userBlogPosts.userProfileImage, item: post, isLiked: post.likers.contains(currentUser)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .accentColor(.clear)
                            }

                        }
                }
                .listStyle(PlainListStyle())
            }.onAppear {
                viewModel.userPosts = []
                viewModel.user = nil
                viewModel.fetchData()
//                if !viewModel.isDataFetched {
//                    viewModel.fetchData()
//                }
            }
            .refreshable {
//                viewModel.isDataFetched = false
                viewModel.userPosts = []
                viewModel.user = nil
                viewModel.fetchData()
            }
            .navigationTitle("Home")
            .toolbar {
                Button {
                    viewModel.showingNewPostView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewPostView) {
                NewPostView(newItemPresented: $viewModel.showingNewPostView, username: currentUser)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentUser: "Akagi")
    }
}
