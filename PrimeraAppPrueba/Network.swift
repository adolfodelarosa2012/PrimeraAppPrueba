//
//  Network.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 22/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

func getData(url:URL, callback:@escaping (Data) -> Void) {
   URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
         if let error = error {
            print("Error de red \(error)")
         }
         return
      }
      if response.statusCode == 200 {
         callback(data)
      } else {
         print("Estado devuelto: \(response.statusCode)")
      }
   }.resume()
}

func getImage(url:URL, callback:@escaping (UIImage) -> Void) {
   getData(url: url) { data in
      if let imagen = UIImage(data: data), let resized = imagen.resize(width: 300) {
         callback(resized)
      } else {
         print("Los datos de imagen no se han validado")
      }
   }
}
