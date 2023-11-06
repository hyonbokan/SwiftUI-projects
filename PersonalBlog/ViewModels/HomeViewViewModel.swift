//
//  HomeViewViewModel.swift
//  PersonalBlog
//
//  Created by dnlab on 11/6/23.
//
import FirebaseFirestore
import Foundation

class HomeViewViewModel: ObservableObject {
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}
