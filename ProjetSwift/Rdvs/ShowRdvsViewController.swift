//
//  ShowRdvsViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 12/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowRdvsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet var rdvPresenter: RdvPresenter!
    @IBOutlet weak var rdvsTable: UITableView!
    
    //Récupération des rendez-vous
    fileprivate lazy var rdvsFetched : NSFetchedResultsController<RendezVous> = {
        let request : NSFetchRequest<RendezVous> = RendezVous.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(RendezVous.dateRDV), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Récupération des rendez-vous
        do{
            try self.rdvsFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Data Source Protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.rdvsFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.rdvsTable.dequeueReusableCell(withIdentifier: "rdvCell", for: indexPath) as! RdvsTableViewCell
        let rdv = self.rdvsFetched.object(at: indexPath)
        self.rdvPresenter.configure(theCell: cell, forRdv: rdv)
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Suppression
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let rdv = self.rdvsFetched.object(at: indexPath)
        CoreDataManager.context.delete(rdv)
    }
    
    //Bouton supprimer
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return [delete]
    }

    // MARK: - TableView Delegate protocol -
    var indexPathForShow: IndexPath? = nil
    
    //Bouton informations
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueShowRdv, sender: self)
    }
    
    // MARK: - NSFetchedResultsController Delegate protocol -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rdvsTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rdvsTable.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.rdvsTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.rdvsTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    

    // MARK: - Navigation
    let segueShowRdv = "showRdvSegue"
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowRdv{
            if let indexPath = self.indexPathForShow{
                let showRdvViewController = segue.destination as! ShowRdvViewController
                let rdv = self.rdvsFetched.object(at: indexPath)
                showRdvViewController.rdv = rdv
                self.rdvsTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
