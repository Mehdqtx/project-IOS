//
//  ShowRdvViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 12/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class ShowRdvViewController: UIViewController {

    @IBOutlet weak var trajetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var prepLabel: UILabel!
    @IBOutlet weak var praticienLabel: UILabel!
    var rdv : RendezVous? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let aRdv = self.rdv{
            self.praticienLabel.text = aRdv.concerner?.nomPraticien
            self.dateLabel.text = DateFormatterHelper.classicFormatFromDate(forDate: aRdv.dateRDV!)
            self.prepLabel.text = DateFormatterHelper.minutesFormatFromDate(forDate: aRdv.dureePrepRDV!) + " minutes"
            self.trajetLabel.text = DateFormatterHelper.minutesFormatFromDate(forDate: aRdv.dureeTrajetRDV!) + " minutes"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
