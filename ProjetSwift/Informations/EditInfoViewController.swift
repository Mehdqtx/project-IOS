//
//  EditInfoViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/02/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class EditInfoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var doctorLastName: UITextField!
    @IBOutlet weak var doctorFirstName: UITextField!
    @IBOutlet weak var informations: UITextField!
    
    var information : Information? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let anInfo = self.information{
            self.doctorLastName.text = anInfo.nomMedecin
            self.doctorFirstName.text = anInfo.prenomMedecin
            self.informations.text = anInfo.info
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

     @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     }
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
