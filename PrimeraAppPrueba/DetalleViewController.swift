//
//  DetalleViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 17/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class DetalleViewController: UITableViewController {
   
   @IBOutlet weak var nombre: UITextField!
   @IBOutlet weak var apellidos: UITextField!
   @IBOutlet weak var departamento: UITextField!
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var imagenAvatar: UIImageView!
   
   var seleccionado:Empleados?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      nombre.text = seleccionado?.first_name
      apellidos.text = seleccionado?.last_name
      departamento.text = seleccionado?.department
      email.text = seleccionado?.email
   }
   
   @IBAction func cambiarAvatar(_ sender: UIButton) {
   }
}
