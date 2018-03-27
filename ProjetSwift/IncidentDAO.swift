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
    
    // sauvegarde de l'incident
    static func save(){
        CoreDataManager.save()
    }
    // supression de l'incident
    static func delete(incident: Incident){
        CoreDataManager.context.delete(incident)
    }
    
    // récupère tous les incidents
    static func fetchAll() -> [Incident]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    //nombre d'élement
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    //creation de l'incident
    static private func createIncident() -> Incident{
        return Incident(context: CoreDataManager.context)
    }
    
    /// Création de l'incident
    ///
    /// - Parameters:
    ///   - type: String type de l'incident
    ///   - date: NSDate date de l'incident
    /// - Returns: Incident, l'incident créé
    static func createIncident(type: String, date: NSDate) -> Incident{
        let dao = self.createIncident()
        dao.dateIncident = date
        dao.typeIncident = type
        
        return dao
    }
}

