//
//  BlogPostItemViewHomeViewHeaderView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemViewHomeViewHeaderView: View {
    let username: String
    let profileImage: String
    
    var body: some View {
        HStack {
            Button(action: {
                print("user tapped")
            }) {
                Image(systemName: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
    BlogPostItemViewHomeViewHeaderView(username: "username", profileImage: "person")
}
