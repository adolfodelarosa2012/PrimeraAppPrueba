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
      let cell = tableView.dequeueReusableCell(withIdentifier: "zeldaEmp", for: indexPath) as! EmpTableViewCell
      let dato = empleados[indexPath.row]
      cell.first_name.text = dato.first_name
      cell.last_name.text = dato.last_name
      cell.department.text = dato.department
      cell.email.text = dato.email
      if let imagen = loadImage(id: dato.id) {
         cell.avatarImage.image = imagen
      } else {
         getImage(url: dato.avatar) { imagen in
            DispatchQueue.main.async {
               if let visible = tableView.indexPathsForVisibleRows, visible.contains(indexPath) {
                  cell.avatarImage.image = imagen
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
   
   @IBAction func ordenar(_ sender: UIBarButtonItem) {
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
      present(alertaOrden, animated: true, completion: nil)
   }
}
