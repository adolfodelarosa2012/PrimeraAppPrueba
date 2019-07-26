//
//  Extension.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 23/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

extension UIImage {
   func resize(width:CGFloat) -> UIImage? {
      let scale = width / self.size.width
      let height = self.size.height * scale
      UIGraphicsBeginImageContext(CGSize(width: width, height: height))
      self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage
   }
}
