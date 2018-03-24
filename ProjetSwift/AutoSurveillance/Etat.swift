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
 
 **type**: Etat -> TypeEtat
 **date**: Etat -> NSDate
 */

extension Etat{
    
    public var type : String{
        return (self.caracteriser?.nomTypeEtat)!
    }
    
    public var date : NSDate{
        return self.dateEtat!
    }
    
    convenience init(date: NSDate, type: String){
        self.init(context: CoreDataManager.context)
        self.dateEtat = date
        let tpe = TypeEtat(context: CoreDataManager.context)
        tpe.nomTypeEtat = type
        self.caracteriser = tpe
    }
}
