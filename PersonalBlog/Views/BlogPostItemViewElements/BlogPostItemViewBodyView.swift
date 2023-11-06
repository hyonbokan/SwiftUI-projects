//
//  BlogPostItemViewBodyView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemViewBodyView: View {
    let title: String
    let postImageName: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20))
            Spacer()
            Image(systemName: postImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 80)
        }
        .frame(height: 80)
    }
}

#Preview {
    BlogPostItemViewBodyView(title: "Post title", postImageName: "photo.artframe")
}
