//
//  ShowSyntheseAutosurveillanceViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowSyntheseAutosurveillanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    fileprivate lazy var stateFetched : NSFetchedResultsController<Etat> = {
        let request : NSFetchRequest<Etat> = Etat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Etat.dateEtat), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    @IBOutlet var syntheseStatePresenter: SyntheseStatePresenter!
    @IBOutlet weak var StateTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load context
        do{
            try self.stateFetched.performFetch()
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
        guard let section = self.stateFetched.sections?[section] else {
            fatalError("Nombre de sections erroné")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.StateTable.dequeueReusableCell(withIdentifier: "syntheseStateCell", for: indexPath) as! SyntheseStateTableViewCell
        let state = self.stateFetched.object(at: indexPath)
        self.syntheseStatePresenter.configure(theCell: cell, forState: state)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
