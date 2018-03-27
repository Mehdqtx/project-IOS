//
//  Incident.swift
//  ProjetSwift
//
//  Created by java on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Incident type
 
 **typeIncident**: Incident -> String
 **date**: Incident -> NSDate
 */

extension Incident{
    // MARK: -
    
    // le type de l'incident
    public var type : String{
        return self.typeIncident!
    }
    
    //la date de l'incident
    public var date : NSDate{
        return self.dateIncident!
    }
    
    /// Initialise un incident
    ///
    /// - Parameters:
    ///   - type: String le type de l'incident
    ///   - date: NSDate la date de l'incident
    convenience init(type: String, date: NSDate){
        self.init(context: CoreDataManager.context)
        self.typeIncident = type
        self.dateIncident = date
    }
}

