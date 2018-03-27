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
    
    class func scheduleNotificationSport()
    {
        
        let content = UNMutableNotificationContent()
        content.title = "Avez vous fait votre sport aujourd'hui ?"
        content.body = "Pensez à valider sur l'appli si ce n'est pas deja fait"
        content.sound = UNNotificationSound.default()
        
        var dateInfo = DateComponents()
        dateInfo.hour = 19
        dateInfo.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        
        let request = UNNotificationRequest(identifier: "sport", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error : Error?) in
            if let theError = error
            {
                print(theError.localizedDescription)
            }
        }
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    class func scheduleNotificationRDV(practicien : String, dateRDV : Date)
    {
        
        let content = UNMutableNotificationContent()
        content.title = "Rappel: RDV avec \(practicien)"
        content.subtitle = "Soyez à l'heure"
        content.sound = UNNotificationSound.default()
        
        let comps = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dateRDV)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        
        let request = UNNotificationRequest(identifier:UUID().uuidString , content: content, trigger: trigger)
        
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
