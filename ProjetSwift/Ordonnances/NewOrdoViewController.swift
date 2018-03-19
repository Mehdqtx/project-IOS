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
    
    @IBOutlet weak var matinSwitch: UISwitch!
    @IBOutlet weak var midiSwitch: UISwitch!
    @IBOutlet weak var soirSwitch: UISwitch!
    
    
    var pickedMedic : String? = nil
    var pickedDose : String? = nil
    var pickedMatin : String? = ""
    var pickedMidi : String? = ""
    var pickedSoir : String? = ""
   
    var medicaments = [Medicaments]()
    let dateDebutPicker = UIDatePicker()
    let dateFinPicker = UIDatePicker()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initMedicamentSeed()
        createDateDebutPicker()
        //createDateFinPicker()
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
        let frequence : String = pickedMatin! + pickedMidi! + pickedSoir!
        guard (nomMedicament != "") && (dose != "") && ((debutT != "") || (finT != "")) && (frequence != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateD = formatter.date(from:debutT)
        let dateF = formatter.date(from:finT)
        
        let ordonnance = Ordonnance(context: CoreDataManager.context)
        let medicament = Medicament(context: CoreDataManager.context)
        let doseI = Dose(context: CoreDataManager.context)
        
        medicament.nomMedicament = nomMedicament
        ordonnance.utiliser = medicament
        
        doseI.libDose = dose
        ordonnance.utiliser?.composer = doseI
        
        ordonnance.dateDebutOrdo = dateD as NSDate?
        ordonnance.dateFinOrdo = dateF as NSDate?
        ordonnance.frequenceHebdo = frequence
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //Mark: - Switch management
    
    
    @IBAction func matinChanged(_ sender: UISwitch) {
        if matinSwitch.isOn {
            pickedMatin = "[Matin]"
        }
        else{
            pickedMatin = ""
        }
    }
    
    @IBAction func midiChanged(_ sender: UISwitch) {
        if midiSwitch.isOn {
            pickedMidi = "[Midi]"
        }
        else{
            pickedMidi = ""
        }
    }
    
    @IBAction func soirChanged(_ sender: UISwitch) {
        if soirSwitch.isOn {
            pickedSoir = "[Soir]"
        }
        else{
            pickedSoir = ""
        }
    }
    
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Picker View management
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 2
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return medicaments[row].medicamentNom
        }
        else {
            let selectedMedic = pickerView.selectedRow(inComponent: 0)
            return medicaments[selectedMedic].doses[row]
        }
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return medicaments.count
        }
        else {
            let selectedMedic = pickerView.selectedRow(inComponent: 0)
            return medicaments[selectedMedic].doses.count
        }
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerView.reloadComponent(1)
        let selectedMedic = pickerView.selectedRow(inComponent: 0)
        let selectedDose = pickerView.selectedRow(inComponent: 1)
        pickedMedic = medicaments[selectedMedic].medicamentNom
        pickedDose = medicaments[selectedMedic].doses[selectedDose]
        

    }
    
    // MARK: - SEEDERS INIT
    
    func initMedicamentSeed(){
        medicaments.append(Medicaments(medicamentNom : "MODOPAR", doses: ["62.5","125","250"]))
        medicaments.append(Medicaments(medicamentNom : "MODOPAR LP", doses: ["125"]))
        medicaments.append(Medicaments(medicamentNom : "MODOPAR DISPERSIBLE", doses: ["125"]))
        medicaments.append(Medicaments(medicamentNom : "SINEMET", doses: ["100","250"]))
        medicaments.append(Medicaments(medicamentNom : "SINEMET LP", doses: ["100", "200"]))
        medicaments.append(Medicaments(medicamentNom : "STALEVO", doses: ["50","75","100","125","150","175","200"]))
        medicaments.append(Medicaments(medicamentNom : "PARLODEL", doses: ["2.5","5","10"]))
        medicaments.append(Medicaments(medicamentNom : "TRIVASTAL", doses: ["20"]))
        medicaments.append(Medicaments(medicamentNom : "TRIVASTAL LP", doses: ["50"]))
        medicaments.append(Medicaments(medicamentNom : "SIFROL", doses: ["0.18", "0.7"]))
        medicaments.append(Medicaments(medicamentNom : "SIFROL LP", doses: ["0.26","0.52","1.05","2.1"]))
        medicaments.append(Medicaments(medicamentNom : "REQUIP", doses: ["0.25","0.5","1","2","5"]))
        medicaments.append(Medicaments(medicamentNom : "REQUIP LP", doses: ["2","4","8"]))
        medicaments.append(Medicaments(medicamentNom : "NEUPRO (PATCH)", doses: ["2","4","6","8"]))
        medicaments.append(Medicaments(medicamentNom : "MANTADIX", doses: ["100"]))
        medicaments.append(Medicaments(medicamentNom : "AZILECT", doses: ["1"]))
        medicaments.append(Medicaments(medicamentNom : "COMTAN", doses: ["200"]))
        medicaments.append(Medicaments(medicamentNom : "ARTANE", doses: ["2","5"]))
        medicaments.append(Medicaments(medicamentNom : "PARKINANE LP", doses: ["2","5"]))
        medicaments.append(Medicaments(medicamentNom : "LEPTICUR", doses: ["10"]))
        medicaments.append(Medicaments(medicamentNom : "LEPONEX", doses: ["25","100"]))
        medicaments.append(Medicaments(medicamentNom : "EXELON", doses: ["1.5","3","4.5","6"]))
        medicaments.append(Medicaments(medicamentNom : "EXELON (PATCH)", doses: ["4.6","9.5"]))
    }
    
    // MARK: - Date Picker View management
    func createDateDebutPicker() {
        
        //format
        dateDebutPicker.datePickerMode = .date
        dateDebutPicker.locale = Locale(identifier:"fr_FR")
        dateFinPicker.datePickerMode = .date
        dateFinPicker.locale = Locale(identifier:"fr_FR")
        
        //toolbar
        let toolbarD = UIToolbar()
        toolbarD.sizeToFit()
        let toolbarF = UIToolbar()
        toolbarF.sizeToFit()
        
        //bar button item
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        toolbarF.setItems([doneButton2], animated: false)
        toolbarD.setItems([doneButton1], animated: false)
        
        dateDebutLabel.inputAccessoryView = toolbarD
        dateFinLabel.inputAccessoryView = toolbarF
        
        //assigning date picker to text field
        dateDebutLabel.inputView = dateDebutPicker
        dateFinLabel.inputView = dateFinPicker
    }
    
    func donePressed() {
        //format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier:"fr_FR")
        
        dateDebutLabel.text = dateFormatter.string(from: dateDebutPicker.date)
        self.view.endEditing(true)
    }
    
    func donePressed2() {
        //format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier:"fr_FR")
        
        dateFinLabel.text = dateFormatter.string(from: dateFinPicker.date)
        self.view.endEditing(true)
    }


}
