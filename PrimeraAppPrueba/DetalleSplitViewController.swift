//
//  DetalleSplitViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 25/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class DetalleSplitViewController: UIViewController {
   
   @IBOutlet weak var label: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      NotificationCenter.default.addObserver(forName: NSNotification.Name("PULSOCELDA"), object: nil, queue: OperationQueue.main) { [weak self] notification in
         if let userInfo = notification.userInfo, let dato = userInfo["EmpleadoPulsado"] as? Empleados {
            self?.label?.text = "\(dato.last_name), \(dato.first_name)"
         }
      }
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
