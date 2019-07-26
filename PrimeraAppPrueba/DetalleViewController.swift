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
   var rowOrigen:Int?
   var imagen:UIImage?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      nombre.text = seleccionado?.first_name
      apellidos.text = seleccionado?.last_name
      departamento.text = seleccionado?.department
      email.text = seleccionado?.email
      imagenAvatar.image = imagen
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(tocoPantalla(sender:)))
      view.addGestureRecognizer(tap)
   }
   
   @objc func tocoPantalla(sender:UITapGestureRecognizer) {
      view.endEditing(true)
   }
   
   @IBAction func cambiarAvatar(_ sender: UIButton) {
      
   }
   
   @IBAction func save(_ sender: UIBarButtonItem) {
      guard let oldEmpleado = seleccionado, let first_name = nombre.text, let last_name = apellidos.text, let email = email.text, let department = departamento.text else {
         return
      }
      if first_name.isEmpty || last_name.isEmpty || email.isEmpty || department.isEmpty {
         showAlert(vc: self, mensaje: "Datos inválidos. Corrija antes de grabar.")
         return
      }
      let newEmpleado = Empleados(id: oldEmpleado.id, first_name: first_name, last_name: last_name, email: email, department: department, avatar: oldEmpleado.avatar)
      performSegue(withIdentifier: "save", sender: newEmpleado)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      guard let newEmpleado = sender as? Empleados,
         let destination = segue.destination as? Empleados1ViewController,
         segue.identifier == "save" else {
         return
      }
      destination.empUpdated = newEmpleado
   }
}
