//
//  RendezVous.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 RendezVous type
 
 **praticien**: RendezVous -> Praticien
 **date**: RendezVous -> NSDate
 **prepDuration**: RendezVous -> NSDate
 **travelDuration**: RendezVous -> NSDate
 */

extension RendezVous{
    
    public var date : NSDate{
        return self.dateRDV!
    }
    
    public var prepDuration : NSDate{
        return self.dureePrepRDV!
    }
    
    public var travelDuration : NSDate{
        return self.dureeTrajetRDV!
    }
    
    public var doctorName : String{
        return (self.concerner?.nomPraticien)!
    }
    
    convenience init(date: NSDate, prepDuration: NSDate, travelDuration: NSDate, doctorName: String, doctorPhone: String){
        self.init(context: CoreDataManager.context)
        self.dateRDV = date
        self.dureeTrajetRDV = travelDuration
        self.dureePrepRDV = prepDuration
        let prt = Praticien(context: CoreDataManager.context)
        prt.nomPraticien = doctorName
        prt.telPraticien = doctorPhone
        self.concerner = prt
    }
}
