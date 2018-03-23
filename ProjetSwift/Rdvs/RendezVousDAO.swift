//
//  RendezVousDAO.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class RendezVousDAO{
    static let request : NSFetchRequest<RendezVous> = RendezVous.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(rdv: RendezVous){
        CoreDataManager.context.delete(rdv)
    }
    
    static func fetchAll() -> [RendezVous]?{
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
    
    static private func createRdv() -> RendezVous{
        return RendezVous(context: CoreDataManager.context)
    }
    
    static func createRdv(date: NSDate, prepDuration: NSDate, travelDuration: NSDate, doctorName: String) -> RendezVous{
        let dao = self.createRdv()
        dao.dateRDV = date
        dao.dureeTrajetRDV = travelDuration
        dao.dureePrepRDV = prepDuration
        dao.concerner?.nomPraticien = doctorName
        return dao
    }
}
