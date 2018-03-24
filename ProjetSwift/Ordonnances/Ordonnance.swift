//
//  Ordonnance.swift
//  ProjetSwift
//
//  Created by java on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Ordonnance type
 

 **medicament**: Ordonnance -> Medicament
 **medicament**: Ordonnance -> Dose
 **dateDebut**: Ordonnance -> NSDate
 **dateFin**: Ordonnance -> NSDate
 **heures**: Ordonnance -> [String]
 */

extension Ordonnance{
    // MARK: -
    
    public var medicament : String{
        return (self.utiliser?.nomMedicament)!
    }
    
    public var dose : String{
        return (self.utiliser?.composer?.libDose)!
    }
    
    public var dateDebut : NSDate{
        return self.dateDebutOrdo!
    }
    
    public var dateFin : NSDate{
        return self.dateFinOrdo!
    }
    
    public var heures : [String]{
        return self.heuresOrdo as! [String]
    }
    
    convenience init(medicament: String, dose: String, dateDebut: NSDate, dateFin: NSDate, heures: [String]){
        self.init(context: CoreDataManager.context)
        self.dateDebutOrdo = dateDebut
        self.dateFinOrdo = dateFin
        self.heuresOrdo = heures as NSObject
        

        let medoc = Medicament(context: CoreDataManager.context)
        let doseU = Dose(context: CoreDataManager.context)
        medoc.nomMedicament = medicament
        doseU.libDose = dose
        medoc.composer = doseU
        self.utiliser = medoc
        self.utiliser?.composer = doseU

    }
}

