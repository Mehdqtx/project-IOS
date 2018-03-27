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
    
    // sauvegarde dans le coredata
    static func save(){
        CoreDataManager.save()
    }
    // supression de l'ordonnance du core data
    static func delete(ordo: Ordonnance){
        CoreDataManager.context.delete(ordo)
    }
    
    //recupère toute les ordonnances du coreData
    static func fetchAll() -> [Ordonnance]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    // nombre d'élement
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    //creation d'une ordonnance
    static private func createOrdo() -> Ordonnance{
        return Ordonnance(context: CoreDataManager.context)
    }
    
    /// Initilise une Ordonnance
    ///
    /// - Parameters:
    ///   - medicament: String nom du médicament choisi dans l'ordonnance
    ///   - dose: String dose du médicament choisi dans l'ordonnance
    ///   - dateD: NSDate date du debut de l'ordonnance
    ///   - dateF: NSDate date de fin de l'ordonnance
    ///   - heures: [String] les heures de prises de l'ordonnance,
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

