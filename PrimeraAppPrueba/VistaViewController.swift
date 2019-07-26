//
//  VistaViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 10/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit

class VistaViewController: UIViewController {
   
   @IBOutlet var etiquetas: [UILabel]!
   @IBOutlet weak var etiqueta2: UILabel!
   @IBOutlet weak var etiqueta1: UILabel!
   override func viewDidLoad() {
      super.viewDidLoad()
      etiqueta1.text = "Ola k ase"
      
   }
   
   @IBAction func pulso(_ sender: UIButton) {
      sender.setTitle("Pulsado", for: .normal)
   }
   
   @IBAction func cambioSegmento(_ sender: UISegmentedControl) {
      etiqueta2.text = "\(sender.selectedSegmentIndex)"
   }
   
   @IBAction func cambio(_ sender: UISlider) {
      etiqueta1.text = "\(sender.value)"
   }
   @IBAction func interruptor(_ sender: UISwitch) {
      etiqueta1.isHidden = !sender.isOn
   }
   
   @IBAction func cambioValorS(_ sender: UIStepper) {
      etiqueta2.text = "\(sender.value)"
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
