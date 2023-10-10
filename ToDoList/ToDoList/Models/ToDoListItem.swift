//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
