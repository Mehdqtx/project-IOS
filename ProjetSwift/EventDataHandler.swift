//
//  EventDataHandler.swift
//  ProjetSwift
//
//  Created by java on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit
import CoreData

class EventDataHandler: NSObject{
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(dateIncident : Date, typeIncident : String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Incident", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(dateIncident, forKey: "dateIncident")
        NSManagedObject.setValue(typeIncident, forKey: "typeIncident")
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    class func fetchObject()-> [Incident]? {
        let context = getContext()
        var incidents: [Incident]? = nil
        do {
            incidents = try context.fetch(Incident.fetchRequest())
            return incidents
        }catch {
            return incidents
        }
    }
}
