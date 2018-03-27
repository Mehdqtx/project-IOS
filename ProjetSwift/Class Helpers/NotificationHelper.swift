//
//  NotificationHelper.swift
//  ProjetSwift
//
//  Created by java on 27/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHelper {

    class func scheduleNotificationMedicament(medicament: String, heurePrevue : Date)
    {
        
        let content = UNMutableNotificationContent()
        content.title = "Rappel de votre prise de médicament"
        content.body = "C'est l'heure, prenez votre \(medicament)"
        content.sound = UNNotificationSound.default()
        let comps = Calendar.current.dateComponents([.hour,.minute], from: heurePrevue)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error : Error?) in
            if let theError = error
            {
                print(theError.localizedDescription)
            }
        }
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}
