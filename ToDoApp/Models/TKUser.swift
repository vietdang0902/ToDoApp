//
//  TKUser.swift
//  ToDoApp
//
//  Created by VietMac
//

import Foundation

struct TKUser: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
