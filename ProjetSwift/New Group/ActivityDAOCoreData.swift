//
//  ActivityDAOCoreData.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 14/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData

class ActivityDAOCoreData: ActivityDAO {
    /*
    fileprivate lazy var activitiesFetched : NSFetchedResultsController<Activite> = {
        let request : NSFetchRequest<Activite> = Activite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Activite.libActivite), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil,cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    */
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Activite")
    var activities : [Activite] = []
    
    
    func getActivity() -> Activity {
        let a : Activity = Activity(activityDuration: 10, frequency: "5", activityName: "Test")
        return a
    }
    
    func deleteActivity(activity: Activity) -> Bool {
        return true
    }
    
    func getAllActivities() -> [Activity] {
        var res : [Activity] = []
        do {
            let results = try CoreDataManager.context.fetch(fetchRequest)
            self.activities = results as! [Activite]
        }catch let error as NSError {
            print(error)
        }
        for a in activities{
            res.append(Activity(activityDuration: a.dureeActivite, frequency: a.frequence!, activityName: a.libActivite!))
        }
        return res
    }
}
