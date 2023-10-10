//
//  ToDoListItemsViews.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//
import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDolistItemViewModel
    @FirestoreQuery var items: [ToDoListItem]
    
//    private let userId: String
    
    init(userId: String) {
//        self.userId = userId
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos"
        )
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)

                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    // Action
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(
                    newItemPresented: $viewModel.showingNewItemView
                )
            }
        }
    }
}

struct ToDoListItemsViews_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "tGTkIXB0Dbfu9CVh4nVc81HOhSP2")
    }
}
