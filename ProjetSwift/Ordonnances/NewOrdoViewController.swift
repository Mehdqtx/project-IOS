//
//  NewOrdoViewController.swift
//  ProjetSwift
//
//  Created by java on 17/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class NewOrdoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
   
    
    @IBOutlet weak var dosePickerView: UIPickerView!
    @IBOutlet weak var medicPickerView: UIPickerView!
    @IBOutlet weak var dateDebutLabel: UITextField!
    @IBOutlet weak var dateFinLabel: UITextField!
    @IBOutlet weak var frequenceLabel: UITextField!
    var pickedMedic : String? = nil
    var pickedDose : String? = nil
   
    
    var typeMedicament = ["Doliprane","Smecta","Eferalgan","Voltarene"]
    
    var doseMedicament = ["50mg","70mg","100mg","120mg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        
        pickedMedic = typeMedicament[0]
        pickedDose = doseMedicament[0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Cancel and Save New Ordonnance
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveOrdo(_ sender: Any) {
        let nomMedicament : String = pickedMedic ?? ""
        let dose : String = pickedDose ?? ""
        let debutT : String = dateDebutLabel.text ?? ""
        let finT : String = dateFinLabel.text ?? ""
        let frequence : String = frequenceLabel.text ?? ""
        
        let ordonnance = Ordonnance(context: CoreDataManager.context)
        ordonnance.dateDebutOrdo = debutT
        ordonnance.dateFinOrdo = finT
        ordonnance.frequenceHebdo = frequence
        ordonnance.nomMedicament = nomMedicament
        ordonnance.doseMedicament = dose
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
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == medicPickerView {
            return typeMedicament[row]
        }
        else {
            return doseMedicament[row]
        }
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == medicPickerView {
            return self.typeMedicament.count
        }
        else {
            return self.doseMedicament.count
        }
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if pickerView == medicPickerView {
            self.pickedMedic = typeMedicament[pickerView.selectedRow(inComponent: 0)]
        }
        else {
            self.pickedDose = doseMedicament[pickerView.selectedRow(inComponent: 0)]
        }
        
    }


}
