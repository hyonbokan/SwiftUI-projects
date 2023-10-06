//
//  ToDoListItemsViews.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewViewModel()
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    // Action
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
    }
}

struct ToDoListItemsViews_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "userID")
    }
}
