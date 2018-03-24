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
 */

extension Autosurveillance{
    
    public var doctorName : String{
        return (self.posseder?.nomPraticien)!
    }
    
    public var date : NSDate{
        return self.dateRDVNeurologue!
    }
    
    convenience init(date: NSDate, doctorName: String){
        self.init(context: CoreDataManager.context)
        self.dateRDVNeurologue = date
        let prt = Praticien(context: CoreDataManager.context)
        prt.nomPraticien = doctorName
        self.posseder = prt
    }
}
