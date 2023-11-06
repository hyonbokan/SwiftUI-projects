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
    
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: HomeViewViewModel(userId: userId))
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/posts")
    }
    
    var body: some View {
        NavigationView {
            VStack{
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userId: "Akagi")
    }
}
