//
//  NewActivityViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController, UITextFieldDelegate {
    
    /*
     @IBOutlet weak var picker: UIPickerView!
     */
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var frequency: UITextField!
    @IBOutlet weak var activityName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Toolbar -
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let frequence : String = frequency.text ?? ""
        let duree : String = duration.text ?? ""
        let nomActivite : String = activityName.text ?? ""
        guard (frequence != "") && (duree != "") && (nomActivite != "") else {
            DialogBoxHelper.alert(view: self, withTitle: "Champ(s) manquant(s)", andMessage: "Veuillez renseigner tous les champs.")
            return
        }
        let activity = Activite(context: CoreDataManager.context)
        let sport = Sport(context: CoreDataManager.context)
        activity.frequence = frequence
        activity.libActivite = nomActivite
        sport.nomSport = nomActivite
        activity.correspondre = sport
        let durationConvert = Int32(duree) ?? 0
        activity.dureeActivite = durationConvert
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
