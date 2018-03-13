//
//  ShowEventViewController.swift
//  ProjetSwift
//
//  Created by java on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,NSFetchedResultsControllerDelegate{

    
    @IBOutlet weak var eventsTable: UITableView!
    
    
    var events : [Incident] = []
    
    fileprivate lazy var eventsFetched : NSFetchedResultsController<Incident> = {
        let request : NSFetchRequest<Incident> = Incident.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Incident.dateIncident), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Load context
        do{
            try self.eventsFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Event data management -
    func delete(eventWithIndex index: Int) -> Bool {
        guard let context = self.getContext() else {return false}
        let event = self.events[index]
        context.delete(event)
        do{
            try context.save()
            self.events.remove(at: index)
            return true
        }
        catch let error as NSError{
            self.alert(error: error)
            return false
        }
    }
    
    
    // MARK: - Table View Data Source Protocol -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.eventsFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier:"eventCell", for: indexPath) as! EventTableViewCell
        let event = self.eventsFetched.object(at: indexPath)
        cell.eventLabel.text = event.typeIncident
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: event.dateIncident! as Date)
        cell.dateEventLabel.text = dateString
        cell.accessoryType = .detailButton
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let event = self.eventsFetched.object(at: indexPath)
        CoreDataManager.context.delete(event)
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
    
   /* // MARK: - Saving
    func saveIncident(withdateIncident : NSDate, andtypeIncident : String){
        // Get Context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("Erreur")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // Create object
        let incident = Incident(context: context)
        // Update values
        incident.dateIncident = withdateIncident
        incident.typeIncident = andtypeIncident
        // Save context
        do{
            try context.save()
            
        }
        catch let error as NSError{
            print(error)
            return
        }
    }*/
    
    // MARK: - TableView Delegate protocol -
    var indexPathForShow: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.indexPathForShow = indexPath
        self.performSegue(withIdentifier: self.segueShowEvent, sender: self)
    }
        
    // MARK: - NSFetchedResultsController Delegate protocol -
        
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            self.eventsTable.beginUpdates()
        }
        
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            self.eventsTable.endUpdates()
            CoreDataManager.save()
        }
        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.eventsTable.deleteRows(at: [indexPath], with: .automatic)
                }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.eventsTable.insertRows(at: [newIndexPath], with: .fade)
                }
            default:
                break
            }
        }
    
    // MARK: - Navigation
   
    // Giving actual informations to show it in the text fields
    let segueShowEvent = "showEventSegue"
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == self.segueShowEvent{
            if let indexPath = self.indexPathForShow{
                let showIncidentViewController = segue.destination as! ShowIncidentViewController
                let event = self.eventsFetched.object(at: indexPath)
                showIncidentViewController.incident = event
                self.eventsTable.deselectRow(at: indexPath, animated: true)
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
    


