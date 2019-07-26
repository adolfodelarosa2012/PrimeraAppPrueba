//
//  CollectionViewCell.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 24/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
   
   @IBOutlet weak var imagen: UIImageView!
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var email: UILabel!
   
   override func awakeFromNib() {
      imagen.layer.cornerRadius = 8.0
      imagen.clipsToBounds = true

      layer.cornerRadius = 8.0
      clipsToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 2, height: 2)
      layer.shadowOpacity = 0.8
   }
   
   override func prepareForReuse() {
      imagen.image = nil
      name.text = nil
      email.text = nil
   }
}
