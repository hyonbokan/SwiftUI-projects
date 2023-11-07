//
//  BlongPostItemView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemView: View {
    @StateObject var viewModel = BlogPostItemViewViewModel()
    let user: User
    let item: BlogPost
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            BlogPostItemViewHeaderView(username: user.name, profileImage: "person")
            BlogPostItemViewBodyView(title: item.title, postImageName: "photo.artframe")
            BlogPostItemViewFooterView(timestamp: item.postedDate, likers: item.likers)
        }
    }
}

struct BlogPostItemView_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostItemView(user: User(name: "Sakuragi", email: "Sakuragi@gmail.com"), item: BlogPost(id: "123", title: "Slam Dunk", postedDate: .date(from: Date()) ?? "", body: "body text", postUrlString: "123", likers: []))
    }
}
