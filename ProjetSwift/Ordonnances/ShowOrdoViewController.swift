//
//  ShowOrdoViewController.swift
//  ProjetSwift
//
//  Created by java on 17/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowOrdoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    
    @IBOutlet weak var medicamentLabel: UILabel!
    @IBOutlet weak var priseTable: UITableView!
    
    @IBOutlet var prisePresenter: PrisePresenter!
    
    
    
    @IBOutlet weak var dateFinLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var dateDebutLabel: UILabel!
    @IBOutlet weak var heureReelLabel: UILabel!
    @IBOutlet weak var dateReelLabel: UILabel!
    
    var ordo : Ordonnance? = nil
    var prises:[PriseReelle]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            prises = try PriseReelle.getAllPrises(ordonnance: self.ordo!)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
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
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (prises?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath) as! PriseTableViewCell
        self.prisePresenter.configure(theCell: cell, forPrise: prises?[indexPath.row])
        
        return cell
    }
    
    
    
    
    
    
}
