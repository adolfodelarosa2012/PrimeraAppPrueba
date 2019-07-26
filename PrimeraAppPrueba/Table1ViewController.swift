//
//  Table1ViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 15/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class Table1ViewController: UITableViewController {
   
   var datos1 = [1,5,8,10,15,19,23,28,32,35]
   var datos2 = ["Hulk", "Iron Man", "Black Widow", "Captain America", "Dr. Strange", "Spiderman", "Scarlett Witch"]
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Uncomment the following line to preserve selection between presentations
      self.clearsSelectionOnViewWillAppear = false
      
      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      self.navigationItem.rightBarButtonItem = self.editButtonItem
   }
   
   // MARK: - Table view data source
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 2
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0 {
         return datos1.count
      } else {
         return datos2.count
      }
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
      if indexPath.section == 0 {
         cell.textLabel?.text = "\(datos1[indexPath.row])"
      } else {
         cell.textLabel?.text = datos2[indexPath.row]
      }
      return cell
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      if section == 0 {
         return "Números"
      } else {
         return "Avengers"
      }
   }
   
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
   }
   
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         if indexPath.section == 0 {
            datos1.remove(at: indexPath.row)
         } else {
            datos2.remove(at: indexPath.row)
         }
         tableView.deleteRows(at: [indexPath], with: .fade)
      }
   }

   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
      if fromIndexPath.section == 0 {
         datos1.insert(datos1.remove(at: fromIndexPath.row), at: to.row)
      }
   }
   
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      if indexPath.section == 1 {
         return false
      }
      return true
   }
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    }
    */
   
}
