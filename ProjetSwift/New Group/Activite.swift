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
 Activity type
 
 **name**: Activity -> String
 **duration**: Activity -> String
 **frequency**: Activity -> String
 */

extension Activite{
    // MARK: -
    
    public var name : String{
        return self.libActivite!
    }

    public var duration : Int32{
        return self.dureeActivite
    }
    
    public var frequency : String{
        return self.frequence!
    }

    convenience init(name: String, duration: Int32, frequency: String){
        self.init(context: CoreDataManager.context)
        self.libActivite = name
        self.dureeActivite  = duration
        self.frequence = frequency
    }
}

