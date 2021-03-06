//
//  NewEventViewController.swift
//  ProjetSwift
//
//  Created by java on 10/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
class NewEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    
    
    
    
    
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var textboxIncident: UITextField!
    
    var incident : Incident? = nil
    var newIncident: Incident?
    var pickerView = UIPickerView()
    var typeEvent = ["Somnolence","Chute","Hallucination","Prise de dispersible","Clic / bolus d'Apokinon"]
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        createDatePicker()
        
        textboxIncident.inputView = pickerView
        textboxIncident.textAlignment = .center
        textboxIncident.placeholder = "Choisissez un type"
        datePickerText.textAlignment = .center
      
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Cancel and Save new event
    @IBAction func annuler(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //sauvegarde de l'evenement lors du clic sur le bouton
    @IBAction func saveEvent(_ sender: Any) {
        
        let dateIncident : String = datePickerText.text ?? ""

        let dateD = DateFormatterHelper.dateFormatFromString(forDate: dateIncident)
        let typeIncident : String = textboxIncident.text ?? ""
        
        self.newIncident = Incident(type: typeIncident, date: dateD)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Picker View management
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return typeEvent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeEvent[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textboxIncident.text = typeEvent[row]
        textboxIncident.resignFirstResponder()
    }
    
    // MARK: - Date Picker View management
    
    //création du date picker associé
    func createDatePicker() {
        //format
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier:"fr_FR")
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerText.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        datePickerText.inputView = datePicker
        
        
    }
    //Bouton qui permet de valider la selection
    func donePressed() {
        //format
        datePickerText.text = DateFormatterHelper.dateFormatFromDate(forDate: datePicker.date as NSDate)
        self.view.endEditing(true)
    }
}

