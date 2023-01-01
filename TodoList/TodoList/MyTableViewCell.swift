//
//  MyTableViewCell.swift
//  TodoList
//
//  Created by Naofel El Alouani on 09/11/2022.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let identifier = "MyTableViewCell"
    
    @IBOutlet var myName : UILabel!
    @IBOutlet var myDesc : UILabel!
    @IBOutlet var myState : UISwitch!
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
 
    public func configure(with title:String, desc:String, state:Bool){
        myName.text = title
        myDesc.text = desc
        myState.setOn(state, animated: true)
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
