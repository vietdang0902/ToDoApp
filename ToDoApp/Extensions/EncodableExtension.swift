//
//  EncodableExtension.swift
//  ToDoApp
//
//  Created by VietMac 
//

import Foundation

extension Encodable {
    func asDict() -> [String : Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String : Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
