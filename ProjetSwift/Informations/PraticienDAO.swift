//
//  PraticienDAO.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class PraticienDAO{
    static let request : NSFetchRequest<Praticien> = Praticien.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(prt: Praticien){
        CoreDataManager.context.delete(prt)
    }
    
    static func fetchAll() -> [Praticien]?{
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
    
    static private func createPraticien() -> Praticien{
        return Praticien(context: CoreDataManager.context)
    }
    
    static func createPraticien(lastName: String, tel: String) -> Praticien{
        let dao = self.createPraticien()
        dao.nomPraticien = lastName
        dao.telPraticien = tel
        return dao
    }
}
