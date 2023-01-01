//
//  DetailViewController.swift
//  TodoList
//
//  Created by Naofel El Alouani on 23/11/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = data {
            name.text = todo.name
            state.setOn(todo.state, animated: true)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateStr = formatter.string(from: todo.date)
            
            date.text = dateStr
            desc.text = todo.desc
        }
        else {
            name.text = "TACHE INCONNUE"
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var state: UISwitch!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var data : Todo?
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        data?.state = !data!.state
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
