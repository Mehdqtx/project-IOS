//
//  NewActivityViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var activityPicker: UIPickerView!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var frequency: UITextField!
    @IBOutlet weak var activityName: UITextField!
    var newActivite: Activite?
    var activitySet : ActiviteSet = ActiviteSet()
    var pickedActivity : String? = nil
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerData.append("Nouvelle activité")
        
        for a in activitySet {
            pickerData.append(a.libActivite!)
        }
    }
    
    // MARK: - Toolbar -
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let frequence : String = frequency.text ?? ""
        let duree : String = duration.text ?? ""
        let nomActivite : String = activityName.text ?? ""
        guard (frequence != "") && (duree != "") && (nomActivite != "" || self.pickedActivity != nil) else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let durationConvert = Int32(duree)!
        if nomActivite != "" {
            self.newActivite = Activite(name: nomActivite, duration: durationConvert, frequency: frequence)
        } else {
            self.newActivite = Activite(name: self.pickedActivity!, duration: durationConvert, frequency: frequence)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            self.pickedActivity = pickerData[pickerView.selectedRow(inComponent: 0)]
            if self.pickedActivity != "Nouvelle activité" {
                self.activityName.isUserInteractionEnabled = false
                self.activityName.backgroundColor = UIColor.gray
                self.activityName.text = ""
            }
            else{
                self.activityName.isUserInteractionEnabled = true
                self.activityName.backgroundColor = UIColor.white
            }
        }
    }
    
    // MARK: - TextFieldDelegate -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
