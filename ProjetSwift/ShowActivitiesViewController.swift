//
//  ShowActivitiesViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 04/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowActivitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    var acts : [String] = []
    var activities : [Activite] = []
    
    fileprivate lazy var activitiesFetched : NSFetchedResultsController<Activite> = {
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Activite.libActivite), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    @IBOutlet weak var TableActivities: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Load context
        do{
            try self.activitiesFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Person data management -
    /*
    func saveNewActivity(withFrequency: String, andDuration: String, andName: String){
        // Get Context
        guard let context = self.getContext() else {return}
        // Create object
        let activity = Activite(context: context)
        // Update values
        activity.frequence = withFrequency
        let durationConvert = Int32(andDuration) ?? 0
        activity.dureeActivite = durationConvert
        activity.libActivite = andName
        // Save context
        do{
            try context.save()
            self.activities.append(activity)
        }
        catch let error as NSError{
            self.alert(error: error)
            return
        }
    }
    */
    
    func delete(activityWithIndex index: Int) -> Bool {
        guard let context = self.getContext() else {return false}
        let activity = self.activities[index]
        context.delete(activity)
        do{
            try context.save()
            self.activities.remove(at: index)
            return true
        }
        catch let error as NSError{
            self.alert(error: error)
            return false
        }
    }
    
    // MARK: - Table View Data Source Protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.activitiesFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.TableActivities.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        let activity = self.activitiesFetched.object(at: indexPath)
        cell.frequencyLabel.text = activity.frequence! + " fois par semaine"
        cell.durationLabel.text = String(activity.dureeActivite) + " minutes"
        cell.activityName.text = activity.libActivite
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let activity = self.activitiesFetched.object(at: indexPath)
        CoreDataManager.context.delete(activity)
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
        self.performSegue(withIdentifier: self.segueShowActivity, sender: self)
    }
    
    // MARK: - NSFetchedResultsController Delegate protocol -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.TableActivities.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.TableActivities.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.TableActivities.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.TableActivities.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    // MARK: - Navigation -

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    let segueShowActivity = "showActivitySegue"
    // Giving actual informations to show it in the text fields
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowActivity{
            if let indexPath = self.indexPathForShow{
                let showActivityViewController = segue.destination as! ShowActivityViewController
                let activity = self.activitiesFetched.object(at: indexPath)
                showActivityViewController.activity = activity
                self.TableActivities.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    /*
    @IBAction func unwindToActivitiesAfterSavingNewActivity(segue: UIStoryboardSegue){
        let newActivityViewController = segue.source as! NewActivityViewController
        let frequency = newActivityViewController.frequency.text ?? ""
        let duration = newActivityViewController.duration.text ?? ""
        let nomActivite = newActivityViewController.pickedActivity ?? ""
        self.saveNewActivity(withFrequency: frequency, andDuration: duration, andName: nomActivite)
        self.TableActivities.reloadData()
    }
    */
    
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
