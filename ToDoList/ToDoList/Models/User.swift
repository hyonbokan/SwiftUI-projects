//
//  User.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
