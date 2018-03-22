//
//  ShowASViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 20/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowASViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    fileprivate lazy var stateFetched : NSFetchedResultsController<Etat> = {
        let request : NSFetchRequest<Etat> = Etat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Etat.dateEtat), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    @IBOutlet var statePresenter: StatePresenter!
    @IBOutlet weak var stateTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    var autosurveillance : Autosurveillance? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load context
        do{
            try self.stateFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }

        // Do any additional setup after loading the view.
        if let anAutosurveillance = self.autosurveillance{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM ' à' hh' h 'mm"
            let dateString = formatter.string(from: anAutosurveillance.dateRDVNeurologue! as Date)
            self.dateLabel.text = dateString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Data Source Protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.stateFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.stateTable.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as! StateTableViewCell
        let state = self.stateFetched.object(at: indexPath)
        do{
            try self.stateFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        print(state.caracteriser?.nomTypeEtat)
        self.statePresenter.configure(theCell: cell, forState: state, andDate: self.autosurveillance?.dateRDVNeurologue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let state = self.stateFetched.object(at: indexPath)
        CoreDataManager.context.delete(state)
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
    
    
    // MARK - helper methods
    
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
