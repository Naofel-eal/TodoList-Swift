//
//  DescView.swift
//  TodoList
//
//  Created by Naofel El Alouani on 23/11/2022.
//

import SwiftUI

struct DescView: View {
    
    let todo : Todo
    
    var body: some View {
        VStack{
            Text(todo.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.medium)
            Form {
                
                HStack {
                    Text("Status: ")
                    Spacer()
                    if todo.state {
                        Text("Done")
                    }
                    else {
                        Text("To do")
                    }
                }
                HStack {
                    Text("Date: ")
                    Spacer()
                    Text(DateFormatter().string(from: todo.date))
                        .font(.callout)
                }
                Text("Description:")
                    .font(.title2)
                Text(todo.desc)
                    .font(.callout)
            }
        }
    }
}

struct DescView_Previews: PreviewProvider {
    static var previews: some View {
        DescView(todo : todos[0])
    }
}
