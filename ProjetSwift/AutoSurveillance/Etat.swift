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
    
    convenience init(date: NSDate, nom: String){
        self.init(context: CoreDataManager.context)
        self.dateEtat = date
        self.nomEtat = nom
    }
}
