//
//  Todo.swift
//  TodoList
//
//  Created by Naofel El Alouani on 09/11/2022.
//

import Foundation

class Todo :CustomStringConvertible{
    var description: String {
        return name
    }
    
    var name : String;
    var desc : String;
    var date : Date;
    var state : Bool;
    
    init(name : String, desc : String, date : Date, state : Bool) {
        self.name = name;
        self.desc = desc;
        self.date = date;
        self.state = state;
    }
}
