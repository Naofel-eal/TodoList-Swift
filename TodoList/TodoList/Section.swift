//
//  Section.swift
//  TodoList
//
//  Created by naofel on 17/12/2022.
//

import Foundation

class Section {
    var date : Date?
    var todos : [Todo]?
    
    init(date : Date, todoList : [Todo]) {
        self.date = date
        self.todos = todoList
    }
}
