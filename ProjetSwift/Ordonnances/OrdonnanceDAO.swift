//
//  OrdonnanceDAO.swift
//  ProjetSwift
//
//  Created by java on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class OrdonnanceDAO{
    static let request : NSFetchRequest<Ordonnance> = Ordonnance.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(rdv: Ordonnance){
        CoreDataManager.context.delete(rdv)
    }
    
    static func fetchAll() -> [Ordonnance]?{
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
    
    static private func createOrdo() -> Ordonnance{
        return Ordonnance(context: CoreDataManager.context)
    }
    
    static func createOrdo(medicament: String, dose: String, dateD: NSDate, dateF: NSDate, heures: [String]) -> Ordonnance{
        let dao = self.createOrdo()
        dao.utiliser?.nomMedicament = medicament
        dao.utiliser?.composer?.libDose = dose
        dao.dateDebutOrdo = dateD
        dao.dateFinOrdo = dateF
        dao.heuresOrdo = heures as NSObject

        return dao
    }
}

