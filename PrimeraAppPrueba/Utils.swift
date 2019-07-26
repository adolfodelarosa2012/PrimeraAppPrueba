//
//  Utils.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 18/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

func showAlert(vc: UIViewController, mensaje:String, titulo:String = "Alerta") {
   let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
   let accion = UIAlertAction(title: "OK", style: .default, handler: nil)
   alerta.addAction(accion)
   vc.present(alerta, animated: true, completion: nil)
}
