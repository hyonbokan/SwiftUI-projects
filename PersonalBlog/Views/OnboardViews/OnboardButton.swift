//
//  OnboardButton.swift
//  PersonalBlog
//
//  Created by dnlab on 11/14/23.
//

import SwiftUI

struct OnboardButton: View {
    let title: String
    let background: Color?
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(background ?? .accentColor)
                Text(title)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
    }
}

#Preview {
    OnboardButton(title: "Title", background: .purple) {
        
    }
}
