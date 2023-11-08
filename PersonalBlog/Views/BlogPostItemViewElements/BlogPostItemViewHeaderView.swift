//
//  BlogPostItemViewHomeViewHeaderView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemViewHeaderView: View {
    let username: String
    let profileImageUrl: URL?
    
    var body: some View {
        HStack {
                if let url = profileImageUrl {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .foregroundColor(.purple)
                }
            Text(username)
                .font(.system(size: 12))
            Spacer()
        }
        .frame(height: 25)
    }
}

#Preview {
    BlogPostItemViewHeaderView(username: "username", profileImageUrl: nil)
}
