//
//  Activite.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 23/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Activite type
 
 **name**: Activite -> String
 **duration**: Activite -> String
 **frequency**: Activite -> String
 **validations**: Activite -> Int32
 */

extension Activite{
    
    public var name : String{
        return self.libActivite!
    }

    public var duration : Int32{
        return self.dureeActivite
    }
    
    public var frequency : String{
        return self.frequence!
    }

    
    public func incValidation() {
        self.nbValidations = self.nbValidations + 1
    }
    
    public func initValidation() {
        self.nbValidations = 0 as Int32
    }

    convenience init(name: String, duration: Int32, frequency: String){
        self.init(context: CoreDataManager.context)
        self.libActivite = name
        self.dureeActivite  = duration
        self.frequence = frequency
        self.initValidation()
    }
}
