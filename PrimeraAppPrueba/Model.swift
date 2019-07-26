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

func saveImage(id:Int, image:UIImage) {
   guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let imagenData = image.pngData() else {
      return
   }
   let ruta = folder.appendingPathComponent("imagen_\(id)").appendingPathExtension("png")
   try? imagenData.write(to: ruta, options: .atomicWrite)
}

func loadImage(id:Int) -> UIImage? {
   guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
   }
   let ruta = folder.appendingPathComponent("imagen_\(id)").appendingPathExtension("png")
   if let data = try? Data(contentsOf: ruta) {
      return UIImage(data: data)
   }
   return nil
}
