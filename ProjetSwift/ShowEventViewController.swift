//
//  ShowEventViewController.swift
//  ProjetSwift
//
//  Created by java on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class ShowEventViewController: UIViewController{
    
    
    var inci : Incident? = nil
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get Context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            print("Erreur")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // Create request for information
        let request : NSFetchRequest<Incident> = Incident.fetchRequest()
        do{
            let requestSize : Int = try context.fetch(request).count
            // If we already have existing incident
            if requestSize > 0{
                try self.inci = context.fetch(request)[context.fetch(request).count-1]
            }
            else{}
        }
        catch let error as NSError{
            print(error)
            return
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func unwindToEventAfterAddingEvent(segue: UIStoryboardSegue){
        print("test event")
    }
    

    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
