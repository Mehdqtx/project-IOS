//
//  NewPraticienViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewPraticienViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var doctorPhoneTextField: UITextField!
    @IBOutlet weak var doctorNameTextField: UITextField!
    var pickerView = UIPickerView()
    var typeActivite : [String] = [
        "kinésithérapeute","orthophoniste","infirmier", "psychologue clinicien","neuropsychologue",
        "neurologue", "médecin généraliste", "psychiatre", "neurochirurgien", "médecin de structure antidouleur"
        ,"gériatre", "médecin spécialiste en médecine physique", "gastro-entérologue", "urologue, gynécologue, sexologue",
         "ophtalmologiste", "ORL-phoniatre", "rhumatologue", "chirurgien orthopédique", "pneumologue",
         "cardiologue", "médecin du travail", "chirurgien-dentiste", "ergothérapeute", "psychomotricien",
         "pédicure-podologue", "diététicien(ne)", "orthoptiste", "assistant de service social", "personnels de transport sanitaire",
         "personnels de soins infirmiers à domicile", "personnels des services d’aide à domicile", "personnels des services d’aide à la personne",
         "personnels de coordination gérontologique", "maisons départementales des personnes handicapées", "éducateur médico-sportif",
         "éducateur médico-sportif", "associations de patients"]
    var newPraticien: Praticien?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        doctorPhoneTextField.inputView = pickerView
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        let phone: String = doctorPhoneTextField.text ?? ""
        let name: String = doctorNameTextField.text ?? ""
        guard (phone != "") && (name != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        self.newPraticien = Praticien(lastName: name, tel: phone)
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
        return typeActivite.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeActivite[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        doctorPhoneTextField.text = typeActivite[row]
        doctorPhoneTextField.resignFirstResponder()
    }

}
