//
//  CoreDataManager.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 11/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject{
    static var context : NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    @discardableResult
    class func save() -> NSError?{
        do{
            try CoreDataManager.context.save()
            return nil
        }catch let error as NSError{
            return error
        }
    }
}
