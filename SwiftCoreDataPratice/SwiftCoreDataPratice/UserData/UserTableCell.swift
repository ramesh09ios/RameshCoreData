//
//  UserTableCell.swift
//  SwiftCoreDataPratice
//
//  Created by BlazeDream on 23/05/18.
//  Copyright © 2018 BlazeDream. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

    @IBOutlet var userName : UILabel!
    @IBOutlet var userPassword : UILabel!
    @IBOutlet var userAge : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func assignUserData(user :UsersRoles)  {
        userName.text = user.name;
        userPassword.text = user.password;
        userAge.text = "\(user.age)";
    }

}
