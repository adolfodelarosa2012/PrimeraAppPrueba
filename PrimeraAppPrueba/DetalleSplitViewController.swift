//
//  DetalleSplitViewController.swift
//  PrimeraAppPrueba
//
//  Created by Dev1 on 25/07/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import UIKit
import MessageUI

class DetalleSplitViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

   @IBOutlet weak var nombre: UITextField!
   @IBOutlet weak var apellidos: UITextField!
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var departamento: UITextField!
   @IBOutlet weak var avatar: UIImageView!
   
   var oldEmpleado:Empleados?
   var imagenCambiada = false
   var dptos:[String] = []
   var row:Int?
   
   override func viewDidLoad() {      
      super.viewDidLoad()
      NotificationCenter.default.addObserver(forName: NSNotification.Name("PULSOCELDA"), object: nil, queue: OperationQueue.main) { [weak self] notification in
         if let userInfo = notification.userInfo, let dato = userInfo["EmpleadoPulsado"] as? Empleados, let row = userInfo["row"] as? Int {
            self?.oldEmpleado = dato
            self?.row = row
            self?.cargaDatos()
         }
      }
      departamento.delegate = self
   }
   
   func cargaDatos() {
      if let emp = oldEmpleado {
         nombre.text = emp.first_name
         apellidos.text = emp.last_name
         email.text = emp.email
         departamento.text = emp.department
         if let imagen = loadImage(id: emp.id) {
            avatar.image = imagen
         }
      }
   }
   
   func cambiarPuesto(_ sender:UITextField) {
      dptos = Array(Set(loadEmpleados().map { $0.department })).sorted()
      let picker = UIPickerView()
      picker.delegate = self
      picker.dataSource = self
      
      sender.inputView = picker
      let toolbar = UIToolbar()
      toolbar.barStyle = .default
      toolbar.isTranslucent = true
      toolbar.tintColor = .gray
      toolbar.sizeToFit()
      
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton(_:)))
      let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton(_:)))
      toolbar.setItems([doneButton, spacer, cancelButton], animated: false)
      sender.inputAccessoryView = toolbar
      
      let indiceActual = dptos.firstIndex { $0 == departamento.text ?? "" }
      picker.selectRow(indiceActual ?? 0, inComponent: 0, animated: false)
   }
   
   @objc func doneButton(_ sender:UIBarButtonItem) {
      departamento.resignFirstResponder()
      
   }

   @objc func cancelButton(_ sender:UIBarButtonItem) {
      departamento.resignFirstResponder()
      departamento.text = oldEmpleado?.department ?? ""
   }

   @IBAction func cambiarAvatar(_ sender: UIButton) {
      let picker = UIImagePickerController()
      picker.sourceType = .photoLibrary
      if let media = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
         picker.mediaTypes = media
      }
      picker.delegate = self
      picker.modalPresentationStyle = .popover
      present(picker, animated: true, completion: nil)
      picker.popoverPresentationController?.sourceView = sender
   }
   
   @IBAction func cancel(_ sender: UIBarButtonItem) {
      cargaDatos()
   }
   
   @IBAction func save(_ sender: UIBarButtonItem) {
      guard let oldEmpleado = oldEmpleado, let first_name = nombre.text, let last_name = apellidos.text, let email = email.text, let department = departamento.text, let row = row else {
         return
      }
      if first_name.isEmpty || last_name.isEmpty || email.isEmpty || department.isEmpty {
         showAlert(vc: self, mensaje: "Datos inválidos. Corrija antes de grabar.")
         return
      }
      let newEmpleado = Empleados(id: oldEmpleado.id, first_name: first_name, last_name: last_name, email: email, department: department, avatar: oldEmpleado.avatar)
      if imagenCambiada, let imagen = avatar.image {
         saveImage(id: newEmpleado.id, image: imagen)
      }
      NotificationCenter.default.post(name: NSNotification.Name("SAVEOK"), object: nil, userInfo: ["Empleado": newEmpleado, "row":row])
   }
   
   @IBAction func enviarEmail(_ sender: UIBarButtonItem) {
      if !MFMailComposeViewController.canSendMail() {
         print("No se pueden enviar emails")
         return
      }
      let email = MFMailComposeViewController()
      if let imagen = avatar.image?.jpegData(compressionQuality: 0.7) {
         email.addAttachmentData(imagen, mimeType: "image/jpeg", fileName: "avatar.jpg")
      }
      email.setSubject("Contacto \(oldEmpleado?.last_name ?? "Nombre")")
      email.setMessageBody("<p>Correo para ti</p>", isHTML: true)
      email.delegate = self
      present(email, animated: true, completion: nil)
   }
   
   @IBAction func compartir(_ sender: UIBarButtonItem) {
      guard let image = avatar.image, let nombre = nombre.text, let apellidos = apellidos.text else {
         return
      }
      let nombreCompleto = "\(apellidos), \(nombre)"
      let activity = UIActivityViewController(activityItems: [image, nombreCompleto], applicationActivities: nil)
      activity.excludedActivityTypes = [.addToReadingList, .airDrop]
      activity.completionWithItemsHandler = { (atype, success, items, error) in
         if success {
            print("Dato compartido")
         }
      }
      activity.modalPresentationStyle = .popover
      activity.popoverPresentationController?.barButtonItem = sender
      present(activity, animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let imagen = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let resized = imagen.resize(width: 300) {
         avatar.image = resized
         imagenCambiada = true
      }
      picker.dismiss(animated: true, completion: nil)
   }
   
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true, completion: nil)
   }
   
   func textFieldDidBeginEditing(_ textField: UITextField) {
      cambiarPuesto(textField)
   }
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return dptos.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return dptos[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      departamento.text = dptos[row]
   }
}
