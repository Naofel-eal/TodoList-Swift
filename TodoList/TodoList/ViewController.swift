//
//  ViewController.swift
//  TodoList
//
//  Created by Naofel El Alouani on 09/11/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].todos!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! TodoTableViewCell
        cell.todoName?.text = data[indexPath.section].todos?[indexPath.row].name
        if (data[indexPath.section].todos![indexPath.row].state) {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todos = todos.sorted(by: {$0.date.compare($1.date) == .orderedAscending})
        reloadSections()
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController {
            let section = table.indexPathForSelectedRow!.section
            let row = table.indexPathForSelectedRow!.row
            vc.data = data[section].todos![row]
        }
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? AddViewController {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToAdd(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? AddViewController {
            if let newTodo = vc.data {
                var find : Bool = false
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let todoDate = formatter.string(from: newTodo.date)
                for section in data {
                    if(formatter.string(from: section.date!) == todoDate){
                        section.todos?.append(newTodo)
                        find = true
                        break
                    }
                }
                if(!find) {
                    data.append(Section(date: newTodo.date, todoList: [newTodo]))
                }
                
                data = data.sorted(by: {$0.date!.compare($1.date!) == .orderedAscending})
                table.reloadData()
            }
            else {
                print("vc.data doesn't exist")
            }
        }
        dataBackup = data
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let conf = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "Supprimer", handler: {(action, view, completionHandler) in
            let row = indexPath.row
            let section = indexPath.section
            self.data[section].todos?.remove(at: row)
            completionHandler(true)
            self.reloadSections()
            self.table.reloadData()
        })])
        dataBackup = data
        return conf
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: data[section].date!)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let name = UILabel()
        let formatter = DateFormatter()
        var dateComponent = DateComponents()
        dateComponent.day = 1
        formatter.dateFormat = "dd/MM/yyyy"
        if(formatter.string(for: data[section].date) == formatter.string(for: Date())){
            name.text = "Today"
        }
        else if((formatter.string(for: data[section].date) == formatter.string(from: Calendar.current.date(byAdding: dateComponent, to: Date())!))){
            name.text = "Tomorrow"
        }
        else {
            name.text = formatter.string(from: data[section].date!)
        }
        name.textColor = UIColor.systemBlue
        name.font = UIFont(name:"HelveticaNeue-Light", size: 30)
        name.textAlignment = .center
        name.sizeToFit()
        name.frame = CGRect(x: (self.view.frame.width-name.frame.width)/2, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        name.sizeToFit()
        view.addSubview(name)
        return view
    }
    
    func reloadSections() {
        var index = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        for section in data {
            if(section.todos?.count == 0) {
                data.remove(at: index)
                index -= 1
            }
            index += 1
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredData : [Section] = []
        if searchText == "" {
            data = dataBackup
            table.reloadData()
        }
        else {
            for section in data {
                let todos : [Todo] = section.todos!
                for todo in todos {
                    if todo.name.uppercased().contains(searchText.uppercased()) {
                        filteredData = addTodoToSection(sectionArr: filteredData, todo: todo)
                        data = filteredData
                    }
                }
            }
        }
        
        table.reloadData()
    }
    
    func addTodoToSection(sectionArr : [Section], todo : Todo) -> [Section] {
        var targetArray = sectionArr
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        for section in targetArray {
            if formatter.string(from: section.date!) == formatter.string(from: todo.date) {
                section.todos?.append(todo)
                return targetArray
            }
        }
        targetArray.append(Section(date: todo.date, todoList: [todo]))
        return targetArray
    }
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var todos : [Todo] = [
        Todo(name: "TP IA", desc: "faire le compte rendu", date: Date(), state: false),
        Todo(name: "TP TS", desc: "faire le compte rendu", date: Date(), state: true),
        Todo(name: "Anglais", desc: "expression ecrite", date: Date(), state: false)
    ]
    
    
    var data : [Section] = [Section(date: Date(), todoList: [
        Todo(name: "TP IA", desc: "faire le compte rendu", date: Date(), state: false),
        Todo(name: "TP TS", desc: "faire le compte rendu", date: Date(), state: true),
        Todo(name: "Anglais", desc: "expression ecrite", date: Date(), state: false)
    ])]
    
    lazy var dataBackup : [Section] = data

}

