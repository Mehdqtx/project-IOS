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
    @IBOutlet weak var heureMatinLabel: UITextField!
    @IBOutlet weak var heureMidiLabel: UITextField!
    @IBOutlet weak var heureSoirLabel: UITextField!
    @IBOutlet weak var heureAutreLabel: UITextField!
    
    @IBOutlet weak var matinSwitch: UISwitch!
    @IBOutlet weak var midiSwitch: UISwitch!
    @IBOutlet weak var soirSwitch: UISwitch!
    @IBOutlet weak var autreSwitch: UISwitch!
    
    
    var pickedMedic : String? = nil
    var pickedDose : String? = nil

    
    @IBOutlet weak var newMedicTextField: UITextField!
    @IBOutlet weak var newDoseTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var medicaments = [Medicaments]()
    var tabHeures = [String]()
    //Creation des date Picker
    let dateDebutPicker = UIDatePicker()
    let dateFinPicker = UIDatePicker()
    let heureMatinPicker = UIDatePicker()
    let heureMidiPicker = UIDatePicker()
    let heureSoirPicker = UIDatePicker()
    let heureAutrePicker = UIDatePicker()
    
    var newOrdonnance : Ordonnance?
    var Prise : PriseReelle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Remplissage du tableau de médicament
        initMedicamentSeed()
        
        createDatePicker()
        
        // Cache les textfield à l'initialisation
        heureMatinLabel.isHidden = true
        heureMidiLabel.isHidden = true
        heureSoirLabel.isHidden = true
        heureAutreLabel.isHidden = true
        newMedicTextField.isHidden = true
        newDoseTextField.isHidden = true
        addButton.isHidden = true
        cancelButton.isHidden = true
        
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
        // Initialisation de toute les variables avec les données saisies
        let nomMedicament : String = pickedMedic ?? ""
        let dose : String = pickedDose ?? ""
        let debutT : String = dateDebutLabel.text ?? ""
        let finT : String = dateFinLabel.text ?? ""
        let heureMatin : String = heureMatinLabel.text ?? ""
        let heureMidi : String = heureMidiLabel.text ?? ""
        let heureSoir : String = heureSoirLabel.text ?? ""
        let heureAutre : String = heureAutreLabel.text ?? ""
        
        //Vérification que tous les champs obligatoire ont été remplies
        guard (nomMedicament != "") && (dose != "") && (debutT != "") && (finT != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }

        // Vérification qu'au moins une heure de prise à été précisé
        guard (heureMatin != "") || (heureMidi != "") || (heureSoir != "") || (heureAutre != "")else{
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner au moins une heure.")
            return
        }
        
        // Ajouts des heures choisi dans la tableau d'heures
        
        if(heureMatin != ""){
            tabHeures.append(heureMatin)
        }
        if(heureMidi != ""){
            tabHeures.append(heureMidi)
        }
        if(heureAutre != ""){
            tabHeures.append(heureSoir)
        }
        if(heureSoir != ""){
            tabHeures.append(heureSoir)
        }
        
        
        // Formattage de la date du format string au format date
        let dateD = DateFormatterHelper.dateFormatFromString(forDate: debutT)
        let dateF = DateFormatterHelper.dateFormatFromString(forDate: finT)
        
      
        //Creation d'une nouvelle ordonnance en précisant tout les paramètres
        self.newOrdonnance = Ordonnance(medicament: nomMedicament, dose: dose, dateDebut: dateD as NSDate, dateFin: dateF as NSDate, heures: tabHeures)
        
        // Fermeture du modal- retour a la page précédente
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //Mark: - Switch management
    
    // Verification que le bouton matin est coché ou non, affichage du textfield
    @IBAction func matinChanged(_ sender: UISwitch) {
        if matinSwitch.isOn {
            heureMatinLabel.isHidden = false
        }
        else{
            heureMatinLabel.isHidden = true
            heureMatinLabel.text = ""
        }
    }
    // Verification que le bouton midi est coché ou non, affichage du textfield
    @IBAction func midiChanged(_ sender: UISwitch) {
        if midiSwitch.isOn {
            heureMidiLabel.isHidden = false
        }
        else{
            heureMidiLabel.isHidden = true
            heureMidiLabel.text = ""
        }
    }
    
    // Verification que le bouton soir est coché ou non, affichage du textfield
    @IBAction func soirChanged(_ sender: UISwitch) {
        if soirSwitch.isOn {
            heureSoirLabel.isHidden = false
        }
        else{
            heureSoirLabel.isHidden = true
            heureSoirLabel.text = ""
        }
    }
    
    // Verification que le bouton autre est coché ou non, affichage du textfield
    @IBAction func autreChanged(_ sender: UISwitch) {
        if autreSwitch.isOn {
            heureAutreLabel.isHidden = false
        }
        else{
            heureAutreLabel.isHidden = true
            heureAutreLabel.text = ""
        }
    }
    //MARK: - Add Medicament Management
    
    //Apparition du text field d'ajout de m"dicament et des bouton add
    @IBAction func addField(_ sender: Any) {
        newMedicTextField.isHidden = false
        newDoseTextField.isHidden = false
        addButton.isHidden = false
        cancelButton.isHidden = false
    }
    
    
    @IBAction func cancelMedicament(_ sender: Any) {
        
        newMedicTextField.isHidden = true
        newMedicTextField.text = ""
        newDoseTextField.isHidden = true
        newDoseTextField.text = ""
        addButton.isHidden = true
        cancelButton.isHidden = true
    }
    
    @IBAction func addMedicament(_ sender: Any) {
        guard (newMedicTextField.text != "") && (newDoseTextField.text != "")  else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Remplissez le nom et la dose du médicament pour pouvoir l'ajouter.")
            return
        }
        medicaments.append(Medicaments(medicamentNom : newMedicTextField.text!, doses: [newDoseTextField.text!]))
        medicPickerView.reloadComponent(0)
        medicPickerView.reloadComponent(1)
        newMedicTextField.text = ""
        newDoseTextField.text = ""
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
    func createDatePicker() {
        
        //format
        dateDebutPicker.datePickerMode = .date
        dateDebutPicker.locale = Locale(identifier:"fr_FR")
        dateFinPicker.minimumDate = dateDebutPicker.date
        
        dateFinPicker.datePickerMode = .date
        dateFinPicker.locale = Locale(identifier:"fr_FR")
        heureMatinPicker.datePickerMode = .time
        heureMatinPicker.locale = Locale(identifier:"fr_FR")
        heureMidiPicker.datePickerMode = .time
        heureMidiPicker.locale = Locale(identifier:"fr_FR")
        heureSoirPicker.datePickerMode = .time
        heureSoirPicker.locale = Locale(identifier:"fr_FR")
        heureAutrePicker.datePickerMode = .time
        heureAutrePicker.locale = Locale(identifier:"fr_FR")
        
        //toolbar
        let toolbarD = UIToolbar()
        toolbarD.sizeToFit()
        let toolbarF = UIToolbar()
        toolbarF.sizeToFit()
        let toolbarHeureMatin = UIToolbar()
        toolbarHeureMatin.sizeToFit()
        let toolbarHeureMidi = UIToolbar()
        toolbarHeureMidi.sizeToFit()
        let toolbarHeureSoir = UIToolbar()
        toolbarHeureSoir.sizeToFit()
        let toolbarHeureAutre = UIToolbar()
        toolbarHeureAutre.sizeToFit()
        
        //bar button item
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        let doneButtonHeureMatin = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedHeureMatin))
        let doneButtonHeureMidi = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedHeureMidi))
        let doneButtonHeureSoir = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedHeureSoir))
        let doneButtonHeureAutre = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedHeureAutre))
        
        toolbarF.setItems([doneButton2], animated: false)
        toolbarD.setItems([doneButton1], animated: false)
        toolbarHeureMatin.setItems([doneButtonHeureMatin], animated: false)
        toolbarHeureMidi.setItems([doneButtonHeureMidi], animated: false)
        toolbarHeureSoir.setItems([doneButtonHeureSoir], animated: false)
        toolbarHeureAutre.setItems([doneButtonHeureAutre], animated: false)
        
        dateDebutLabel.inputAccessoryView = toolbarD
        dateFinLabel.inputAccessoryView = toolbarF
        heureMatinLabel.inputAccessoryView = toolbarHeureMatin
        heureMidiLabel.inputAccessoryView = toolbarHeureMidi
        heureSoirLabel.inputAccessoryView = toolbarHeureSoir
        heureAutreLabel.inputAccessoryView = toolbarHeureAutre
        
        //assigning date picker to text field
        dateDebutLabel.inputView = dateDebutPicker
        dateFinLabel.inputView = dateFinPicker
        heureMatinLabel.inputView = heureMatinPicker
        heureMidiLabel.inputView = heureMidiPicker
        heureSoirLabel.inputView = heureSoirPicker
        heureAutreLabel.inputView = heureAutrePicker
    }
    
    func donePressed() {
        //format
        dateDebutLabel.text = DateFormatterHelper.dateFormatFromDate(forDate: dateDebutPicker.date as NSDate)
        self.view.endEditing(true)
    }
    
    func donePressed2() {
        //format
        dateFinLabel.text = DateFormatterHelper.dateFormatFromDate(forDate: dateFinPicker.date as NSDate)
        self.view.endEditing(true)
    }
    
    func donePressedHeureMatin() {
        //format
        heureMatinLabel.text = DateFormatterHelper.hoursFormatFromDate(forDate: heureMatinPicker.date as NSDate)
        self.view.endEditing(true)
    }
    func donePressedHeureMidi() {
        //format
        heureMidiLabel.text = DateFormatterHelper.hoursFormatFromDate(forDate: heureMidiPicker.date as NSDate)
        self.view.endEditing(true)
    }
    
    func donePressedHeureSoir() {
        //format
        heureSoirLabel.text = DateFormatterHelper.hoursFormatFromDate(forDate: heureSoirPicker.date as NSDate)
        self.view.endEditing(true)
    }
    func donePressedHeureAutre() {
        //format
        heureAutreLabel.text = DateFormatterHelper.hoursFormatFromDate(forDate: heureAutrePicker.date as NSDate)
        self.view.endEditing(true)
    }

    
}
