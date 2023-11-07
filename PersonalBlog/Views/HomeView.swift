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
                                // Header view for the blog post with user's name and profile image
                                BlogPostItemViewHeaderView(username: userBlogPosts.owner.name, profileImage: "person.fill")
                                // Body view for the blog post with title and post image
                                BlogPostItemViewBodyView(title: post.title, postImageName: "photo.artframe")
                                // Optionally, include a footer view if you have one
                                // BlogPostItemViewFooterView(...)
                            }
                        }

                }
            }.onAppear {
                if !viewModel.isDataFetched {
                    viewModel.fetchData()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
