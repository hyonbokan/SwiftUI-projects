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
                                BlogPostItemViewHeaderView(username: userBlogPosts.owner.name, profileImageUrl: userBlogPosts.userProfileImage)
                                BlogPostItemViewBodyView(title: post.title, postImageUrlString: post.postUrlString)
                                BlogPostItemViewFooterView(timestamp: post.postedDate, likers: post.likers)
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
