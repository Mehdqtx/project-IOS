//
//  ShowInfoViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/02/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{

    @IBOutlet var praticienPresenter: PraticienPresenter!
    var info : Information? = nil

    @IBOutlet weak var nomMedecin: UILabel!
    @IBOutlet weak var prenomMedecin: UILabel!
    @IBOutlet weak var praticienTable: UITableView!
    
    //Chargement des praticiens
    fileprivate lazy var praticiensFetched : NSFetchedResultsController<Praticien> = {
        let request : NSFetchRequest<Praticien> = Praticien.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Praticien.nomPraticien), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Chargement des praticiens
        do{
            try self.praticiensFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
        //Chargement du médecin traitant
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("Erreur")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // Create request for information
        let request : NSFetchRequest<Information> = Information.fetchRequest()
        do{
            let requestSize : Int = try context.fetch(request).count
            // If we already have existing information
            if requestSize > 0{
                try self.info = context.fetch(request)[context.fetch(request).count-1]
            }
            else{}
        }
        catch let error as NSError{
            print(error)
            return
        }
        // Set the labels
        self.nomMedecin.text = self.info?.nomMedecin
        self.prenomMedecin.text = self.info?.prenomMedecin
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Saving
    func saveInfo(withFirstName : String, andLastName : String){
        // Get Context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("Erreur")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // Create object
        let information = Information(context: context)
        // Update values
        information.nomMedecin = andLastName
        information.prenomMedecin = withFirstName
        // Save context
        do{
            try context.save()
            self.info = information
        }
        catch let error as NSError{
            print(error)
            return
        }
    }
    
    // MARK: - Navigation
    @IBAction func unwindToInfoAfterEditInfo(segue: UIStoryboardSegue){
        let editInfoController = segue.source as! EditInfoViewController
        let nomMedecin = editInfoController.doctorLastName.text ?? ""
        let prenomMedecin = editInfoController.doctorFirstName.text ?? ""
        self.saveInfo(withFirstName: prenomMedecin, andLastName: nomMedecin)
        self.nomMedecin.text = self.info?.nomMedecin
        self.prenomMedecin.text = self.info?.prenomMedecin
    }
    
    let segueEditInfoId = "editInfo"
    // Giving actual informations to show it in the text fields
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueEditInfoId{
            let editInfoViewController = segue.destination as! EditInfoViewController
            editInfoViewController.information = self.info
        }
    }
    
    // MARK: - Table View Data Source Protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.praticiensFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.praticienTable.dequeueReusableCell(withIdentifier: "praticienCell", for: indexPath) as! PraticienTableViewCell
        let praticien = self.praticiensFetched.object(at: indexPath)
        self.praticienPresenter.configure(theCell: cell, forPraticien: praticien)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Suppression
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let praticien = self.praticiensFetched.object(at: indexPath)
        CoreDataManager.context.delete(praticien)
    }
    
    //Bouton supprimer
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    // MARK: - NSFetchedResultsController Delegate protocol -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.praticienTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.praticienTable.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                self.praticienTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.praticienTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
}
