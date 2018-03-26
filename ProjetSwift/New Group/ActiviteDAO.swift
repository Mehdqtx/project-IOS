//
//  ActiviteDAO.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class ActiviteDAO{
    static let request : NSFetchRequest<Activite> = Activite.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(activity: Activite){
        CoreDataManager.context.delete(activity)
    }
    
    static func fetchAll() -> [Activite]?{
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
    
    static private func createActivity() -> Activite{
        return Activite(context: CoreDataManager.context)
    }
    
    static func createActivity(name: String, duration: Int32, frequency: String) -> Activite{
        let dao = self.createActivity()
        dao.libActivite = name
        dao.dureeActivite = duration
        dao.frequence = frequency
        dao.nbValidations = 0
        return dao
    }
}
