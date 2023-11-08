//
//  BlongPostItemView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemView: View {
//    @StateObject var viewModel = BlogPostItemViewViewModel()
    let user: User
    let userImageUrl: URL?
    let item: BlogPost
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            BlogPostItemViewHeaderView(username: user.name, profileImageUrl: userImageUrl)
            BlogPostItemViewBodyView(title: item.title, postImageUrlString: item.postUrlString)
            BlogPostItemViewFooterView(timestamp: item.postedDate, likers: item.likers)
        }
    }
}

struct BlogPostItemView_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostItemView(user: User(name: "Sakuragi", email: "Sakuragi@gmail.com", profileImageUrl: nil), userImageUrl: nil, item: BlogPost(id: "123", title: "Slam Dunk", postedDate: .date(from: Date()) ?? "", body: "body text", postUrlString: "123", likers: []))
    }
}
