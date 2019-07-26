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
   guard let rutaBundle = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json"), let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return []
   }
   let rutaDisco = folder.appendingPathComponent("datosEmpleados").appendingPathExtension("json")
   do {
      let datos = try Data(contentsOf: FileManager.default.fileExists(atPath: rutaDisco.relativePath) ? rutaDisco : rutaBundle)
      let carga = try JSONDecoder().decode([Empleados].self, from: datos)
      return carga
   } catch {
      print("Error en la serialización \(error)")
   }
   return []
}

func saveEmpleados(empleados:[Empleados]) {
   guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return
   }
   print(folder)
   let ruta = folder.appendingPathComponent("datosEmpleados").appendingPathExtension("json")
   do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let datosEmp = try encoder.encode(empleados)
      try datosEmp.write(to: ruta, options: .atomicWrite)
   } catch {
      print("Error grabando datos \(error)")
   }
}
