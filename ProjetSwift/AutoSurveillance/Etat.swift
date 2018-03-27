//
//  Etat.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Etat type
 
 **nom**: Etat -> String
 **date**: Etat -> NSDate
 */

extension Etat{
    
    public var type : String{
        return self.nomEtat!
    }
    
    public var date : NSDate{
        return self.dateEtat!
    }
    
    static func getAllStates(autosurveillance: Autosurveillance) throws -> [Etat] {
        let predicate: NSPredicate = NSPredicate(format: "composer == %@", autosurveillance)
        let request: NSFetchRequest<Etat> = Etat.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Etat.dateEtat), ascending: true)]
        request.predicate = predicate
        do{
            let states:[Etat] = try CoreDataManager.context.fetch(request)
            return states
        }catch let error as NSError{
            throw error
        }
    }
    
    convenience init(date: NSDate, nom: String, autos: Autosurveillance){
        self.init(context: CoreDataManager.context)
        self.dateEtat = date
        self.nomEtat = nom
        self.composer = autos
    }
}
