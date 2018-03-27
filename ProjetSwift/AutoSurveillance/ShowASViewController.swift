//
//  ShowASViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 20/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowASViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet var statePresenter: StatePresenter!
    @IBOutlet weak var stateTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    var autosurveillance : Autosurveillance? = nil
    var states:[Etat]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Récupération de tous les états correspondants à l'autosurveillance voulue
        do{
            self.states = try Etat.getAllStates(autosurveillance: self.autosurveillance!)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }

        //Initialisation du label en fonction de l'autosurveillance
        if let anAutosurveillance = self.autosurveillance{
            self.dateLabel.text = "Rendez-vous du : " + DateFormatterHelper.classicFormatFromDate(forDate: anAutosurveillance.dateRDVNeurologue!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Data Source Protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (states?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.stateTable.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as! StateTableViewCell
        //let state = self.stateFetched.object(at: indexPath)
        self.statePresenter.configure(theCell: cell, forState: states?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Suppression
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        CoreDataManager.context.delete((states?[indexPath.row])!)
    }
    
    //Bouton supprimer
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    // MARK: - TableView Delegate protocol -
    var indexPathForShow: IndexPath? = nil
    
    // MARK: - NSFetchedResultsController Delegate protocol -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.stateTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.stateTable.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.stateTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.stateTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    // MARK: - Navigation -
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    let segueShowState = "newStateSegue"
    // Giving actual informations to show it in the text fields
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowState{
            let newStateViewController = segue.destination as! NewStateViewController
            let autosurveillance = self.autosurveillance
            newStateViewController.autosurveillance = autosurveillance
        }
    }
    
    //Actualisation lors du retour sur la page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // get the persistence facade that hides the storage business logic.
        do{
            states = try Etat.getAllStates(autosurveillance: self.autosurveillance!)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        self.stateTable.reloadData()
    }
}
