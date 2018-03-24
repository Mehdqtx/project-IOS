//
//  IncidentDAO.swift
//  ProjetSwift
//
//  Created by java on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class IncidentDAO{
    static let request : NSFetchRequest<Incident> = Incident.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(incident: Incident){
        CoreDataManager.context.delete(incident)
    }
    
    static func fetchAll() -> [Incident]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static private func createIncident() -> Incident{
        return Incident(context: CoreDataManager.context)
    }
    
    static func createIncident(type: String, date: NSDate) -> Incident{
        let dao = self.createIncident()
        dao.dateIncident = date
        dao.typeIncident = type
        
        return dao
    }
}

