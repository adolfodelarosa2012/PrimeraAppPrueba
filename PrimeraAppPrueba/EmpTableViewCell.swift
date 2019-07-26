//
//  EmpTableViewCell.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 17/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class EmpTableViewCell: UITableViewCell {
   @IBOutlet weak var avatarImage: UIImageView!
   @IBOutlet weak var first_name: UILabel!
   @IBOutlet weak var last_name: UILabel!
   @IBOutlet weak var department: UILabel!
   @IBOutlet weak var email: UILabel!
   
   override func prepareForReuse() {
      avatarImage.image = nil
      first_name.text = nil
      last_name.text = nil
      department.text = nil
      email.text = nil
   }
}
