//
//  ShowIncidentViewController.swift
//  ProjetSwift
//
//  Created by java on 12/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class ShowIncidentViewController: UIViewController{
    
    @IBOutlet weak var typeIncidentLabel: UILabel!
    @IBOutlet weak var dateIncidentLabel: UILabel!
    
    var incident : Incident? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let anIncident = self.incident{
            
            //affichage des données dans le label
            self.typeIncidentLabel.text = anIncident.typeIncident
            self.dateIncidentLabel.text = DateFormatterHelper.dateFormatFromDate(forDate: anIncident.dateIncident!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        return
    }
}
