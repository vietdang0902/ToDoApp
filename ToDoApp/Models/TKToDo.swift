//
//  TKToDo.swift
//  ToDoApp
//
//  Created by VietMac
//

import Foundation

struct TKToDoItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
}
