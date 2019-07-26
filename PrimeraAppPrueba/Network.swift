//
//  Network.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 22/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

func getImage(url:URL, callback:@escaping (UIImage) -> Void) {
   URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data, let imagen = UIImage(data: data) {
         callback(imagen)
      }
      }.resume()
}
