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
        VStack(alignment: .leading) {
            if let imageUrl = URL(string: viewModel.postUrlString) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProfileView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
            }
            Text(viewModel.title)
                .font(.subheadline)
                .padding([.horizontal, .top])
        }
    }
}

struct ProfilePostView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePostView(viewModel: BlogPost(id: "123", title: "Post Title", postedDate: "123", body: "Body", postUrlString: "url", likers: []))
    }
}
