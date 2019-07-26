//
//  Model.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 16/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

struct Empleados:Codable {
   let id:Int
   var first_name:String
   var last_name:String
   var email:String
   var department:String
   let avatar:URL
}

func loadEmpleados() -> [Empleados] {
   guard let ruta = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json") else {
      return []
   }
   do {
      let datos = try Data(contentsOf: ruta)
      let carga = try JSONDecoder().decode([Empleados].self, from: datos)
      return carga
   } catch {
      print("Error en la serialización \(error)")
   }
   return []
}
