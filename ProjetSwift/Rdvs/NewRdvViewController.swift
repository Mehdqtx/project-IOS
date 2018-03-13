//
//  NewRdvViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 12/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewRdvViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickedPraticien : String? = nil
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pathTextField: UITextField!
    @IBOutlet weak var prepTextField: UITextField!
    @IBOutlet weak var praticienPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         pickerData = ["Jean", "Paul", "Martin"].sorted()
         pickedPraticien = pickerData[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        let praticien : String = pickedPraticien ?? ""
        guard (praticien != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let rdv = RendezVous(context: CoreDataManager.context)
        rdv.nomPraticien = praticien
        rdv.dateRDV = datePicker.date as NSDate?
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        let prep = formatter.date(from: self.prepTextField.text ?? "")
        rdv.dureePrepRDV = prep as NSDate?
        let trajet = formatter.date(from: self.pathTextField.text ?? "")
        rdv.dureeTrajetRDV = trajet as NSDate?
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
        self.pickedPraticien = pickerData[pickerView.selectedRow(inComponent: 0)]
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
