//
//  ShowOrdoViewController.swift
//  ProjetSwift
//
//  Created by java on 17/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowOrdoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate{

    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (prises?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath) as! PriseTableViewCell
        self.prisePresenter.configure(theCell: cell, forPrise: prises?[indexPath.row])
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - TableView Delegate protocol -
    var indexPathForShow: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueShowPrise, sender: self)
    }
    
    // MARK: - NSFetchedResultsController Delegate protocol -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.priseTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.priseTable.endUpdates()
        CoreDataManager.save()
    }
    
    // MARK: - Navigation
    let segueShowPrise = "showPriseSegue"
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowPrise{
            if let indexPath = self.indexPathForShow{
                let editPriseViewController = segue.destination as! EditPriseViewController
                let prise = self.prises?[indexPath.row]
                editPriseViewController.prise = prise
                self.priseTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    

    
    
    
    
    
}
