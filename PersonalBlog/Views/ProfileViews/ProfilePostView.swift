//
//  ProfilePostView.swift
//  PersonalBlog
//
//  Created by Michael Kan on 2023/11/12.
//

import SwiftUI

struct ProfilePostView: View {
    let viewModel: BlogPost
    
    var body: some View {
        VStack(alignment: .center) {
            if let imageUrl = URL(string: viewModel.postUrlString) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                Image(systemName: "photo")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            Text(viewModel.title)
                .font(.caption)
                .bold()
                .foregroundStyle(Color(UIColor.label))
//                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 150, height: 15)
                .lineLimit(0)
        }
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.purple, lineWidth: 3))
        .frame(width: 180, height: 120)
        .clipped()
    }
}

struct ProfilePostView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePostView(viewModel: BlogPost(id: "123", title: "Post Title", postedDate: "123", body: "Body", postUrlString: "url", likers: []))
    }
}
