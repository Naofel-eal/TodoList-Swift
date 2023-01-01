//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by Naofel El Alouani on 23/11/2022.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoName: UILabel!
    @IBOutlet weak var todoDesc: UILabel!
    @IBOutlet weak var todoDate: UILabel!
    @IBOutlet weak var todoState: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
