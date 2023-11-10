//
//  BlogPostItemViewBodyView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemViewBodyView: View {
    let title: String
    let postImageUrlString: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20))
            Spacer()
            if let url = URL(string: postImageUrlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 80)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 80)
                    .foregroundColor(.purple)
            }
        }
        .frame(height: 80)
    }
}

//#Preview {
//    BlogPostItemViewBodyView(title: "Post title", postImageUrlString: "photo.artframe")
//}
