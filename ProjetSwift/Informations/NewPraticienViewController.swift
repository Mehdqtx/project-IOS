//
//  NewPraticienViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewPraticienViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var doctorPhoneTextField: UITextField!
    @IBOutlet weak var doctorNameTextField: UITextField!
    var newPraticien: Praticien?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
