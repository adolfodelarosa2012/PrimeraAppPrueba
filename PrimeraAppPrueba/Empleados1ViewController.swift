//
//  Empleados1ViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 16/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class Empleados1ViewController: UITableViewController {
   
   var empleados = loadEmpleados()
   var empUpdated:Empleados?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.clearsSelectionOnViewWillAppear = false
      self.navigationItem.rightBarButtonItem = self.editButtonItem
   }
   
   // MARK: - Table view data source
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return empleados.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "zeldaEmp", for: indexPath)
      let dato = empleados[indexPath.row]
      if let cellPhone = cell as? EmpTableViewCell {
         cellPhone.first_name.text = dato.first_name
         cellPhone.last_name.text = dato.last_name
         cellPhone.department.text = dato.department
         cellPhone.email.text = dato.email
         if let imagen = loadImage(id: dato.id) {
            cellPhone.avatarImage.image = imagen
         } else {
            getImage(url: dato.avatar) { imagen in
               DispatchQueue.main.async {
                  if let visible = tableView.indexPathsForVisibleRows, visible.contains(indexPath) {
                     cellPhone.avatarImage.image = imagen
                  }
                  saveImage(id: dato.id, image: imagen)
               }
            }
         }
         return cellPhone
      } else {
         cell.textLabel?.text = "\(dato.last_name), \(dato.first_name)"
         cell.detailTextLabel?.text = dato.email
         if let imagen = loadImage(id: dato.id) {
            cell.imageView?.image = imagen
         } else {
            getImage(url: dato.avatar) { imagen in
               DispatchQueue.main.async {
                  if let visible = tableView.indexPathsForVisibleRows, visible.contains(indexPath) {
                     cell.imageView?.image = imagen
                  }
                  saveImage(id: dato.id, image: imagen)
               }
            }
         }
      }
      return cell
   }
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "irDetalle" {
         guard let destino = segue.destination as? DetalleViewController,
            let origen = sender as? EmpTableViewCell,
            let indexPath = tableView.indexPath(for: origen) else {
            return
         }
         destino.seleccionado = empleados[indexPath.row]
         destino.rowOrigen = indexPath.row
         destino.imagen = origen.avatarImage.image
      }
   }
   
   @IBAction func salidaDetalle(_ segue:UIStoryboardSegue) {
      if let update = empUpdated, segue.identifier == "save", let source = segue.source as? DetalleViewController, let row = source.rowOrigen {
         empleados[row] = update
         saveEmpleados(empleados: empleados)
         let indexPath = IndexPath(row: row, section: 0)
         tableView.reloadRows(at: [indexPath], with: .none)
         empUpdated = nil
      }
   }
   
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         empleados.remove(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with: .fade)
         saveEmpleados(empleados: empleados)
      }
   }
   
   func mostrarOrden(_ barButtonItem:UIBarButtonItem? = nil) {
      let alertaOrden = UIAlertController(title: "Ordenación", message: "Seleccione el tipo de orden de la lista", preferredStyle: .actionSheet)
      let accionAscendente = UIAlertAction(title: "Ascendente", style: .default) { [weak self] _ in
         self?.empleados.sort { "\($0.last_name), \($0.first_name)" < "\($1.last_name), \($1.first_name)" }
         self?.tableView.reloadData()
      }
      let accionDescendente = UIAlertAction(title: "Descendente", style: .default) { [weak self] _ in
         self?.empleados.sort { "\($0.last_name), \($0.first_name)" > "\($1.last_name), \($1.first_name)" }
         self?.tableView.reloadData()
      }
      let accionDefecto = UIAlertAction(title: "Por defecto", style: .default) {
         [weak self] _ in
         self?.empleados.sort { $0.id < $1.id }
         self?.tableView.reloadData()
      }
      alertaOrden.addAction(accionAscendente)
      alertaOrden.addAction(accionDescendente)
      alertaOrden.addAction(accionDefecto)
      
      if let popOver = alertaOrden.popoverPresentationController {
         popOver.barButtonItem = barButtonItem
      }
      
      present(alertaOrden, animated: true, completion: nil)
   }
   
   @IBAction func ordenar(_ sender: UIBarButtonItem) {
      mostrarOrden()
   }
   
   @IBAction func ordenariPad(_ sender: UIBarButtonItem) {
      mostrarOrden(sender)
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if UIDevice.current.userInterfaceIdiom == .pad {
         let dato = empleados[indexPath.row]
         NotificationCenter.default.post(name: NSNotification.Name("PULSOCELDA"), object: nil, userInfo: ["EmpleadoPulsado":dato])
      }
   }
}
