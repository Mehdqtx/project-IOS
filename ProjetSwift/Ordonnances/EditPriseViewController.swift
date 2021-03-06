//
//  EditPriseViewController.swift
//  ProjetSwift
//
//  Created by java on 25/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class EditPriseViewController: UIViewController{
    
    var prise : PriseReelle? = nil
    
    @IBOutlet weak var datePrevueLabel: UILabel!
    @IBOutlet weak var heurePrisePrevueLabel: UILabel!
    @IBOutlet weak var datePriseReelle: UILabel!
    @IBOutlet weak var heurePriseReelle: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let aPrise = self.prise{
            
            // Affichage des labels
            //Formattage de toute les dates au format string pour affichage dans les labels
            self.datePrevueLabel.text =  DateFormatterHelper.dateFormatFromDate(forDate: aPrise.datePrisePrevue!)
            self.heurePrisePrevueLabel.text = DateFormatterHelper.hoursFormatFromDate(forDate: aPrise.heurePrisePrevue!)
            if aPrise.datePriseReelle != nil{
                self.datePriseReelle.text =  DateFormatterHelper.dateFormatFromDate(forDate: aPrise.datePriseReelle!)
                self.heurePriseReelle.text =  DateFormatterHelper.hoursFormatFromDate(forDate: aPrise.heurePriseReelle!)
            }
            else{
                self.datePriseReelle.text = "Non prise"
                self.heurePriseReelle.text = "Non prise"
            }
        }
        
    }
    
    // Bouton d'action de validation d'une prise
    @IBAction func ValiderPrise(_ sender: UIBarButtonItem) {
        if let aPrise = self.prise{
            let dateA = self.prise?.datePrisePrevue
            let dateB = Date()
            //Verification que lorsque l'utilisateur veut cliquer sur valider la prise, la date de la prise est la date du jour ou une date antérieur
            if (dateA?.compare(dateB) == .orderedAscending) || (dateA?.compare(dateB) == .orderedSame){
                do{
                    try aPrise.editPrise(datePrise: NSDate(), heurePrise: NSDate())
                    self.dismiss(animated: true, completion: nil)
                }catch let error as NSError{
                    DialogBoxHelper.alert(view: self, error: error)
                }
            }
            else{
                DialogBoxHelper.alert(view: self, withTitle: "Mauvais prise", andMessage: "Vous ne pouvez pas valider une prise qui ne s'est pas encore déroulé dans le temps")
            }
        }
        else{
             DialogBoxHelper.alert(view: self, withTitle: "Erreur", andMessage: "Impossible de valider la prise")
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
