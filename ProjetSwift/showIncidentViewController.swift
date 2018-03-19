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
            self.typeIncidentLabel.text = anIncident.typeIncident
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            self.dateIncidentLabel.text = formatter.string(from: anIncident.dateIncident! as Date)
        }
    }
    
    override func didReceiveMemoryWarning() {
        return
    }
}
