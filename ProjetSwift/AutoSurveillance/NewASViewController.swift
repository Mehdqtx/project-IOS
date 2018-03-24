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

        // Do any additional setup after loading the view.
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
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        let prep = formatter.date(from: preparation) as NSDate?
        let trajet = formatter.date(from: travel) as NSDate?
        self.newAutosurveillance = Autosurveillance(date: datePicker.date as NSDate, doctorName: praticien, prepDuration: prep!, travelDuration: trajet!)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
