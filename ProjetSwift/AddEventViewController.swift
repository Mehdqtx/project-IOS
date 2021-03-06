//
//  AddEventViewController.swift
//  ProjetSwift
//
//  Created by java on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    
   

  
    
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var textboxIncident: UITextField!
    
    var pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var typeEvent = ["Somnolence","Chute","Hallucination","Prise de dispersible","Clic / bolus d'Apokinon"]
    
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
    func createDatePicker() {
        //format
        datePicker.datePickerMode = .date
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
    
    func donePressed() {
        //format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        
        datePickerText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}

