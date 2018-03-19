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
    
    @IBOutlet weak var frequenceLabel: UILabel!
    @IBOutlet weak var dateFinLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var dateDebutLabel: UILabel!
    
    var ordo : Ordonnance? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let anOrdonnance = self.ordo{
            self.medicamentLabel.text = anOrdonnance.utiliser?.nomMedicament
            self.doseLabel.text = anOrdonnance.utiliser?.composer?.libDose
            self.frequenceLabel.text = anOrdonnance.frequenceHebdo
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateSD = formatter.string(from: anOrdonnance.dateDebutOrdo! as Date)
            let dateSF = formatter.string(from: anOrdonnance.dateFinOrdo! as Date)
            self.dateFinLabel.text = "Fin du traitement: le " + dateSF
            self.dateDebutLabel.text = "Début du traitement: le " + dateSD
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
