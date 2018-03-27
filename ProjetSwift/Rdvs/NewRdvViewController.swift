//
//  NewRdvViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 12/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class NewRdvViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var pickedPraticien : String? = nil
    var pickerData: [String] = [String]()
    var praticienSet : PraticienSet = PraticienSet()
    @IBOutlet weak var praticienPicker: UIPickerView!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pathTextField: UITextField!
    @IBOutlet weak var prepTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let prepPicker = UIDatePicker()
    let trajetPicker = UIDatePicker()
    var newRendezVous: RendezVous?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimePicker()
        
        self.pickerData.append("Nouveau")
        
        for p in praticienSet {
            pickerData.append(p.nomPraticien!)
        }
        datePicker.minimumDate = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let praticien : String = self.addTextField.text ?? ""
        let path : String = self.pathTextField.text ?? ""
        let preparation : String = self.prepTextField.text ?? ""
        let phone : String = self.phoneTextField.text ?? ""
        guard (praticien != "" || self.pickedPraticien != nil) && (path != "") && (preparation != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let dateRDV = datePicker.date as NSDate?
        let prep = DateFormatterHelper.minutesFormatFromString(forDate: preparation)
        let trajet = DateFormatterHelper.minutesFormatFromString(forDate: path)
        if praticien != "" {
            self.newRendezVous = RendezVous(date: dateRDV!, prepDuration: prep, travelDuration: trajet, doctorName: praticien, doctorPhone: phone)
        }
        else{
            self.newRendezVous = RendezVous(date: dateRDV!, prepDuration: prep, travelDuration: trajet, doctorName: self.pickedPraticien!, doctorPhone: "")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Picker Management -
     // The number of columns of data
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
    
     // The data to return for the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
     }
     
     // The number of rows of data
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
     }
     
     // Catpure the picker view selection
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     // This method is triggered whenever the user makes a change to the picker selection.
     // The parameter named row and component represents what was selected.
        if(pickerData.count > 0){
            self.pickedPraticien = pickerData[pickerView.selectedRow(inComponent: 0)]
            if self.pickedPraticien != "Nouveau" {
                self.addTextField.isUserInteractionEnabled = false
                self.addTextField.backgroundColor = UIColor.gray
                self.addTextField.text = ""
                self.phoneTextField.isUserInteractionEnabled = false
                self.phoneTextField.backgroundColor = UIColor.gray
                self.phoneTextField.text = ""
            }
            else{
                self.addTextField.isUserInteractionEnabled = true
                self.addTextField.backgroundColor = UIColor.white
                self.phoneTextField.isUserInteractionEnabled = true
                self.phoneTextField.backgroundColor = UIColor.white
            }
        }
     }
    
    // MARK: - TextFieldDelegate -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Date Picker View management
    func createTimePicker() {
        
        //format
        prepPicker.datePickerMode = .countDownTimer
        prepPicker.locale = Locale(identifier:"fr_FR")
        trajetPicker.datePickerMode = .countDownTimer
        trajetPicker.locale = Locale(identifier:"fr_FR")
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let toolbarT = UIToolbar()
        toolbarT.sizeToFit()
        
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let doneButtonT = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedT))
    
        toolbar.setItems([doneButton], animated: false)
        toolbarT.setItems([doneButtonT], animated: false)
        
        prepTextField.inputAccessoryView = toolbar
        pathTextField.inputAccessoryView = toolbarT
        
        
        //assigning date picker to text field
        prepTextField.inputView = prepPicker
        pathTextField.inputView = trajetPicker
        
    }
    
    func donePressed() {
        //format
        prepTextField.text = DateFormatterHelper.timeFormatFromDate(forDate: prepPicker.date as NSDate)
        self.view.endEditing(true)
    }
    func donePressedT() {
        //format
        pathTextField.text = DateFormatterHelper.timeFormatFromDate(forDate: trajetPicker.date as NSDate)
        self.view.endEditing(true)
    }
}
