//
//  HomeView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseFirestoreSwift
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewViewModel
    @FirestoreQuery var items: [BlogPost]
    @FirestoreQuery var users: [User]
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: HomeViewViewModel(userId: userId))
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/posts")
        self._users = FirestoreQuery(collectionPath: "users")
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List(items) { item in
                    BlogPostItemView(user: User(id: "", name: "Sakuragi", email: "Sakuragi@gmail.com", profileImageUrl: "person"), item: BlogPost(id: "123", title: "Slam Dunk", postedDate: .date(from: Date()) ?? "", body: "body text", postUrlString: "123", likers: []))
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userId: "Akagi")
    }
}
