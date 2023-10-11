//
//  ToDolistItemViewModel.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

/// ViewModel for a single to do list item view (each row in items list)

class ToDolistItemViewModel: ObservableObject {
    
    init() {}
    
    func toggleIsDone(item: ToDoListItem) {
        // need to create a copy to mutate the state .isDone
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
