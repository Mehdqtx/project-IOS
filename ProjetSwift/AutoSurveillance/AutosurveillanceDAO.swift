//
//  AutosurveillanceDAO.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class AutosurveillanceDAO{
    static let request : NSFetchRequest<Autosurveillance> = Autosurveillance.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(autosurveillance: Autosurveillance){
        CoreDataManager.context.delete(autosurveillance)
    }
    
    static func fetchAll() -> [Autosurveillance]?{
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
    
    static private func createAutosurveillance() -> Autosurveillance{
        return Autosurveillance(context: CoreDataManager.context)
    }
    
    static func createAutosurveillance(date: NSDate, doctorName: String) -> Autosurveillance{
        let dao = self.createAutosurveillance()
        dao.dateRDVNeurologue = date
        dao.posseder?.nomPraticien = doctorName
        return dao
    }
}
