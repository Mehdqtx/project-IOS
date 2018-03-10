//
//  ShowEventViewController.swift
//  ProjetSwift
//
//  Created by java on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowEventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    @IBOutlet weak var eventsTable: UITableView!
    
    
    var events : [Incident] = []
    
    @IBAction func addEvent(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get Context
        guard let context = self.getContext(errorMsg: "Impossible de charger les données") else {return}
        // Create request for information
        let request : NSFetchRequest<Incident> = Incident.fetchRequest()
        do{
            try self.events = context.fetch(request)
        }
        catch let error as NSError{
            self.alert(error: error)
            return
        }
    }
    
    // MARK: - Event data management -
    
    func saveNewActivity(withEvent: String, andDateEvent: NSDate){
        // Get Context
        guard let context = self.getContext(errorMsg: "Sauvegarde échouée") else {return}
        // Create object
        let incident = Incident(context: context)
        // Update values
        incident.typeIncident = withEvent
        incident.dateIncident = andDateEvent
        
        // Save context
        do{
            try context.save()
            self.events.append(incident)
        }
        catch let error as NSError{
            self.alert(error: error)
            return
        }
    }
    
    // MARK: - Table View Data Source Protocol -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.eventsTable.dequeueReusableCell(withIdentifier:"eventCell", for: indexPath) as! EventTableViewCell
        cell.eventLabel.text = self.events[indexPath.row].typeIncident
        cell.dateEventLabel.text = String(describing: self.events[indexPath.row].dateIncident)
        return cell
    }
    

    
    
    // MARK: - Saving
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
    }
    
    // MARK: - Navigation
    let segueShowEvent = "showEventSegue"
    // Giving actual informations to show it in the text fields

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* if segue.identifier == self.segueShowEvent{
            if let indexPath == self.eventsTable.indexPathForSelectedRow{
                let showEventViewController = segue.destination as! AddEventViewController
                showEventViewController.incident = self.events[indexPath.row]
                self.eventsTable.deselectRow(at: index, animated: true)
                
            }
        }*/
    }
    
    @IBAction func unwindToEventsAfterSavingNewEvent(segue: UIStoryboardSegue){
        let newEventController = segue.source as! NewEventViewController
        print("dateEvent : \(String(describing: newEventController.textboxIncident.text))")
        print("typeEvent : \(String(describing: newEventController.datePickerText.text))")
        }

    

    // MARK - helper methods
    func getContext(errorMsg: String, userInfoMsg: String = "Impossible de récupérer les données du contexte")-> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alert(withTitle: errorMsg, andMessage: userInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
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
    


