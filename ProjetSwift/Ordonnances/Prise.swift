//
//  Prise.swift
//  ProjetSwift
//
//  Created by java on 25/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Type Prise
 
 **datePrevue**: Prise -> NSDate
 **heurePrevue**: Prise -> NSDate
  **datePriseReelle**: Prise -> NSDate
  **heurePriseReelle**: Prise -> NSDate
 **associer**: Prise -> Ordonnance
 */

extension PriseReelle{
    
    /// Initialiser une `PriseReelle`
    ///
    /// - Parameters:
    ///   - withHeurePrisePrevue: `NSDate` heure prévue pour cette prise`
    ///   - withDatePrisePrevue: `NSDate` date prévue pour cette prise`
    ///   - withOrdonnance: `Ordonnance` l'ordonnance associé à cette prise
    static func createPrise(withHeurePrisePrevue: NSDate, withDatePrisePrevue: NSDate,withOrdonnance: Ordonnance) throws -> PriseReelle {
        let prise = PriseReelle(context: CoreDataManager.context)
        prise.datePrisePrevue = withDatePrisePrevue
        prise.heurePrisePrevue = withHeurePrisePrevue
        prise.datePriseReelle = nil
        prise.heurePriseReelle = nil
        prise.associer = withOrdonnance
        do{
            try CoreDataManager.save()
        }catch let error as NSError{
            throw error
        }
        return prise
    }
    
    
    /// Recupère toute les prises d'une ordonnance
    ///
    /// - Parameter ordonnance: Ordonnance du patient
    /// - Returns:[PriseReelle] l'ensemble des prises pour l'ordonnance entré en paramètre
    /// - Throws:
    static func getAllPrises(ordonnance: Ordonnance) throws -> [PriseReelle] {
        let predicate: NSPredicate = NSPredicate(format: "associer == %@", ordonnance)
        let request: NSFetchRequest<PriseReelle> = PriseReelle.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(PriseReelle.datePrisePrevue), ascending: true)]
        request.predicate = predicate
        do{
            let prises:[PriseReelle] = try CoreDataManager.context.fetch(request)
            return prises
        }catch let error as NSError{
            throw error
        }
    }
    
    /// Recupère toute les prises valider par le patient
    ///
    /// - Parameter ordonnance: Ordonnance du patient
    /// - Returns:[PriseReelle] l'ensemble des prises pour l'ordonnance entré en paramètre
    /// - Throws:
    static func getAllPrisesValider() throws -> [PriseReelle] {
        let predicate: NSPredicate = NSPredicate(format: "valider != %@",false as CVarArg)
        let request: NSFetchRequest<PriseReelle> = PriseReelle.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(PriseReelle.datePriseReelle), ascending: true)]
        request.predicate = predicate
        do{
            let prises:[PriseReelle] = try CoreDataManager.context.fetch(request)
            return prises
        }catch let error as NSError{
            throw error
        }
    }
    
    //
    /// Edite la prise lors de la validation
    ///
    /// - Parameters:
    ///   - datePrise: NSDate date de la prise réelle
    ///   - heurePrise: NSdate heure de la prise réelle
    /// - Throws: 
    func editPrise( datePrise: NSDate, heurePrise: NSDate) throws {
        
        self.datePriseReelle = datePrise
        self.heurePriseReelle = heurePrise
        self.valider = true
        
        do{
            try CoreDataManager.save()
        }catch let error as NSError{
            throw error
        }
    }
    
}
