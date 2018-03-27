//
//  ShowSyntheseActivitiesViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 26/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowSyntheseActivitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet var syntheseActivitiesPresenter: SyntheseActivitiesPresenter!
    @IBOutlet weak var activitiesTable: UITableView!
    
    //Chargement de toutes les activités
    fileprivate lazy var activitiesFetched : NSFetchedResultsController<Activite> = {
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Activite.libActivite), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Chargement de toutes les activités
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
    
    // MARK: - Table View Data Source Protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.activitiesFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.activitiesTable.dequeueReusableCell(withIdentifier: "syntheseActivitiesCell", for: indexPath) as! SyntheseActivitiesTableViewCell
        let activity = self.activitiesFetched.object(at: indexPath)
        self.syntheseActivitiesPresenter.configure(theCell: cell, forActivity: activity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
