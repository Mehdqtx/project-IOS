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
            self.praticienLabel.text = aRdv.nomPraticien
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM ' à' hh'h'mm"
            let dateString = formatter.string(from: aRdv.dateRDV! as Date)
            self.dateLabel.text = dateString
            formatter.dateFormat = "mm 'minutes'"
            print(aRdv.dureePrepRDV)
            let prepString = formatter.string(from: aRdv.dureePrepRDV! as Date)
            self.prepLabel.text = prepString
            let pathString = formatter.string(from: aRdv.dureeTrajetRDV! as Date)
            self.trajetLabel.text = pathString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
