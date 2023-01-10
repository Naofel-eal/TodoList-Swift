//
//  AddViewController.swift
//  TodoList
//
//  Created by Naofel El Alouani on 09/12/2022.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        desc.delegate = self
        desc.text = "Placeholder"
        desc.textColor = UIColor.lightGray
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        print ("ok")
        return true
    }
    
    var data: Todo?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        data = Todo(name: name.text!, desc: desc.text, date: datePicker.date, state: false)
    }
    
}
