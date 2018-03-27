//
//  NewASViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 19/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewASViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var travelTextField: UITextField!
    @IBOutlet weak var prepTextField: UITextField!
    @IBOutlet weak var praticienTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var newAutosurveillance: Autosurveillance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Toolbar -
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let praticien : String = self.praticienTextField.text ?? ""
        let travel : String = self.travelTextField.text ?? ""
        let preparation : String = self.prepTextField.text ?? ""
        guard (praticien != "") && (travel != "") && (preparation != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let prep = DateFormatterHelper.minutesFormatFromString(forDate: preparation)
        let trajet = DateFormatterHelper.minutesFormatFromString(forDate: travel)
        self.newAutosurveillance = Autosurveillance(date: datePicker.date as NSDate, doctorName: praticien, prepDuration: prep, travelDuration: trajet)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - TextFieldDelegate -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
