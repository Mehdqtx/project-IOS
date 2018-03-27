//
//  ShowOrdosViewController.swift
//  ProjetSwift
//
//  Created by java on 17/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowOrdosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var ordosTable: UITableView!
    @IBOutlet var ordoPresenter: OrdoPresenter!
    
    
    // Récupération de toutes les ordonnances du patient
    fileprivate lazy var ordosFetched : NSFetchedResultsController<Ordonnance> = {
        let request : NSFetchRequest<Ordonnance> = Ordonnance.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Ordonnance.utiliser.nomMedicament), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try self.ordosFetched.performFetch()
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
        guard let section = self.ordosFetched.sections?[section] else {
        fatalError("Nombre de sections erroné")
    }
    return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ordosTable.dequeueReusableCell(withIdentifier: "ordoCell", for: indexPath) as! OrdosTableViewCell
        let ordonnance = self.ordosFetched.object(at: indexPath)
        self.ordoPresenter.configure(theCell: cell, forOrdo: ordonnance)
        cell.accessoryType = .detailButton
        return cell
    }
    
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let ordo = self.ordosFetched.object(at: indexPath)
        CoreDataManager.context.delete(ordo)
    }
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        print("edit")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        let edit = UITableViewRowAction(style: .default, title: "Edit", handler: self.editHandlerAction)
        delete.backgroundColor = UIColor.red
        edit.backgroundColor = UIColor.blue
        return [delete, edit]
    }
    
    // MARK: - TableView Delegate protocol -
    var indexPathForShow: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueShowOrdo, sender: self)
    }
    
    // MARK: - NSFetchedResultsController Delegate protocol -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.ordosTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.ordosTable.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.ordosTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.ordosTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
    // MARK: - Navigation
    let segueShowOrdo = "showOrdoSegue"
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowOrdo{
            if let indexPath = self.indexPathForShow{
                let showOrdoViewController = segue.destination as! ShowOrdoViewController
                let ordo = self.ordosFetched.object(at: indexPath)
                showOrdoViewController.ordo = ordo
                self.ordosTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
   
}

