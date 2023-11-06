//
//  BlogPostItemViewFooterView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//

import SwiftUI

struct BlogPostItemViewFooterView: View {
    let timestamp: Date
    let likers: [String]
    var body: some View {
        HStack {
            let date = String.date(from: timestamp) ?? "None"
            Text(date)
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
         }
         .frame(height: 30)
     }
}

#Preview {
    BlogPostItemViewFooterView(timestamp: Date(), likers: [])
}
