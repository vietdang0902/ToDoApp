//
//  ToDoItemViewModel.swift
//  ToDoApp
//
//  Created by VietMac
//

import Foundation

class ToDoItemViewModel: ObservableObject {
    init() {}
    
    let calendar = Calendar.current
    
    func dueDateString(item: TKToDoItem) -> String {
        let dueDate = Date(timeIntervalSince1970: item.dueDate)
        if calendar.isDateInToday(dueDate) {
            return "Today\n at " + Date(timeIntervalSince1970: item.dueDate).formatted(date: .omitted, time: .shortened)
        } else if calendar.isDateInTomorrow(dueDate) {
            return "Tomorrow\n at " + Date(timeIntervalSince1970: item.dueDate).formatted(date: .omitted, time: .shortened)
        } else if calendar.isDateInYesterday(dueDate) {
            return "Yesterday\n at " + Date(timeIntervalSince1970: item.dueDate).formatted(date: .omitted, time: .shortened)
        } else {
            return Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .omitted) + "\nat " +  Date(timeIntervalSince1970: item.dueDate).formatted(date: .omitted, time: .shortened)
        }
    }
}
