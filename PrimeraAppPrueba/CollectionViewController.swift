//
//  CollectionViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 24/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
   
   var empleados = loadEmpleados()
   var empUpdated:Empleados?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.clearsSelectionOnViewWillAppear = false
   }
   
   // MARK: - Navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "detalleCelda" {
         guard let destino = segue.destination as? DetalleViewController,
            let origen = sender as? CollectionViewCell,
            let indexPath = collectionView.indexPath(for: origen) else {
               return
         }
         destino.seleccionado = empleados[indexPath.row]
         destino.rowOrigen = indexPath.row
         destino.imagen = origen.imagen.image
         destino.origen = .coleccion
      }
   }
   
   // MARK: UICollectionViewDataSource
   
   override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return empleados.count
   }
   
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zelda", for: indexPath) as! CollectionViewCell
      let dato = empleados[indexPath.row]
      cell.name.text = "\(dato.last_name), \(dato.first_name)"
      cell.email.text = dato.email
      if let imagen = loadImage(id: dato.id) {
         cell.imagen.image = imagen
      } else {
         getImage(url: dato.avatar) { imagen in
            DispatchQueue.main.async {
               let visible = collectionView.indexPathsForVisibleItems
               if visible.contains(indexPath) {
                  cell.imagen.image = imagen
                  saveImage(id: dato.id, image: imagen)
               }
            }
         }
      }
      return cell
   }
   
   @IBAction func salidaCollectionDetalle(_ segue:UIStoryboardSegue) {
      if let update = empUpdated, segue.identifier == "salidaCol", let source = segue.source as? DetalleViewController, let row = source.rowOrigen {
         empleados[row] = update
         saveEmpleados(empleados: empleados)
         let indexPath = IndexPath(row: row, section: 0)
         collectionView.reloadItems(at: [indexPath])
         empUpdated = nil
      }
   }
   
   // MARK: UICollectionViewDelegate
   
   /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    return true
    }
    */
   
   /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    return true
    }
    */
   
   /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
    return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
    return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
   
}
