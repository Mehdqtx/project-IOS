//
//  EtatDAO.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class EtatDAO{
    static let request : NSFetchRequest<Etat> = Etat.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(etat: Etat){
        CoreDataManager.context.delete(etat)
    }
    
    static func fetchAll() -> [Etat]?{
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
    
    static private func createEtat() -> Etat{
        return Etat(context: CoreDataManager.context)
    }
    
    static func createEtat(date: NSDate, nom: String) -> Etat{
        let dao = self.createEtat()
        dao.dateEtat = date
        dao.nomEtat = nom
        return dao
    }
}
