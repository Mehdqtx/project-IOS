//
//  Praticien.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

// MARK: -
/**
 Praticien type
 
 **lastName**: Praticien -> String
 **tel**: Praticien -> String
 */

extension Praticien{
    
    public var lastName : String{
        return self.nomPraticien!
    }
    
    public var tel : String{
        return self.telPraticien!
    }
    
    convenience init(lastName: String, tel: String){
        self.init(context: CoreDataManager.context)
        self.nomPraticien = lastName
        self.telPraticien = tel
    }
}
