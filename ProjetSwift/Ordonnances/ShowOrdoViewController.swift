//
//  ShowOrdoViewController.swift
//  ProjetSwift
//
//  Created by java on 17/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class ShowOrdoViewController: UIViewController {
    
    @IBOutlet weak var medicamentLabel: UILabel!
    

    @IBOutlet weak var dateFinLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var dateDebutLabel: UILabel!
    @IBOutlet weak var heureReelLabel: UILabel!
    @IBOutlet weak var dateReelLabel: UILabel!
    
    var ordo : Ordonnance? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let anOrdonnance = self.ordo{
            self.medicamentLabel.text = anOrdonnance.utiliser?.nomMedicament
            self.doseLabel.text = anOrdonnance.utiliser?.composer?.libDose

            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateSD = formatter.string(from: anOrdonnance.dateDebutOrdo! as Date)
            self.dateDebutLabel.text = "Début du traitement: le " + dateSD
            
            if anOrdonnance.dateFinOrdo != nil {
                let dateSF = formatter.string(from: anOrdonnance.dateFinOrdo! as Date)
                self.dateFinLabel.text = "Fin du traitement: le " + dateSF
            }
            else{
                self.dateFinLabel.text = "Durée indeterminée"
            }
            
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* @IBAction func savePriseReel(_ sender: UIButton) {
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy.HH.mm"
        
        let prise = PriseReelle(context:CoreDataManager.context)
        
        prise.datePriseReelle = date
        self.ordo?.associer = prise
        
        print(prise.datePriseReelle)
        print(self.ordo?.associer)
        print(self.ordo?.utiliser?.nomMedicament)
        let result = formatter.string(from: date as Date)
        print(result)
        dateReelLabel.text = result
    
    }*/
    
    
}
