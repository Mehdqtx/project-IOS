//
//  Autosurveillance.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Autosurveillance type
 
 **praticien**: Autosurveillance -> Praticien
 **date**: Autosurveillance -> NSDate
 **prepDuration**: RendezVous -> NSDate
 **travelDuration**: RendezVous -> NSDate
 */

extension Autosurveillance{
    
    public var doctorName : String{
        return (self.posseder?.nomPraticien)!
    }
    
    public var date : NSDate{
        return self.dateRDVNeurologue!
    }
    
    public var prepDuration : NSDate{
        return self.dureePreparation!
    }
    
    public var travelDuration : NSDate{
        return self.dureeTrajet!
    }
    
    convenience init(date: NSDate, doctorName: String, prepDuration: NSDate, travelDuration: NSDate){
        self.init(context: CoreDataManager.context)
        self.dateRDVNeurologue = date
        self.dureeTrajet = travelDuration
        self.dureePreparation = prepDuration
        let prt = Praticien(context: CoreDataManager.context)
        prt.nomPraticien = doctorName
        self.posseder = prt
    }
}
