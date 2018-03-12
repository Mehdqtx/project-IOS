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

    @IBOutlet weak var rdvsTable: UITableView!
    
    fileprivate lazy var rdvsFetched : NSFetchedResultsController<RendezVous> = {
        let request : NSFetchRequest<RendezVous> = RendezVous.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(RendezVous.dateRDV), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        cell.praticienLabel.text = rdv.nomPraticien
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let rdv = self.rdvsFetched.object(at: indexPath)
        CoreDataManager.context.delete(rdv)
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
    
    // MARK - helper methods
    func getContext()-> NSManagedObjectContext?{
        return CoreDataManager.context
    }
    
    func alert(withTitle title: String, andMessage msg: String = ""){
        let alert = UIAlertController(title: title, message: msg,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func alert(error: NSError){
        self.alert(withTitle: "\(error)", andMessage: "\(error.userInfo)")
    }

}
