//
//  BlogPostItemViewFooterView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemViewFooterView: View {
    let timestamp: String
    let likers: [String]
    var body: some View {
        HStack {
              Text(timestamp)
                 .font(.subheadline)
                 .foregroundColor(.gray)
             Spacer()
             Button(action: {
                 // Action for like button
             }) {
                 Image(systemName: "basketball")
                     .resizable()
                     .frame(width: 18, height: 18)
                     .foregroundColor(.purple)
             }
            Text("\(likers.count)")
                 .font(.subheadline)
//                 .foregroundColor(.purple)
         }
         .frame(height: 30)
     }
}

//#Preview {
//    BlogPostItemViewFooterView(timestamp: "time stamp", likers: [])
//}
