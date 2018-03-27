//
//  Ordonnance.swift
//  ProjetSwift
//
//  Created by java on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

// MARK: -
/**
 Ordonnance type
 

 **medicament**: Ordonnance -> Medicament
 **medicament**: Ordonnance -> Dose
 **dateDebut**: Ordonnance -> NSDate
 **dateFin**: Ordonnance -> NSDate
 **heures**: Ordonnance -> [String]
 */

extension Ordonnance{
    // MARK: -
    
    //nom du médicament
    public var medicament : String{
        return (self.utiliser?.nomMedicament)!
    }
    //dose du médicament
    public var dose : String{
        return (self.utiliser?.composer?.libDose)!
    }
    // date de debut de l'ordonnance
    public var dateDebut : NSDate{
        return self.dateDebutOrdo!
    }
    // date de fin de l'ordonnance
    public var dateFin : NSDate{
        return self.dateFinOrdo!
    }
    //heures de prises de l'ordonnance
    public var heures : [String]{
        return self.heuresOrdo as! [String]
    }
    
    /// Initilise une Ordonnance
    ///
    /// - Parameters:
    ///   - medicament: String nom du médicament choisi dans l'ordonnance
    ///   - dose: String dose du médicament choisi dans l'ordonnance
    ///   - dateDebut: NSDate date du debut de l'ordonnance
    ///   - dateFin: NSDate date de fin de l'ordonnance
    ///   - heures: [String] les heures de prises de l'ordonnance,
    convenience init(medicament: String, dose: String, dateDebut: NSDate, dateFin: NSDate, heures: [String]){
        self.init(context: CoreDataManager.context)
        self.dateDebutOrdo = dateDebut
        self.dateFinOrdo = dateFin
        self.heuresOrdo = heures as NSObject
        
        let medoc = Medicament(context: CoreDataManager.context)
        let doseU = Dose(context: CoreDataManager.context)
        
        medoc.nomMedicament = medicament
        doseU.libDose = dose
        medoc.composer = doseU
        self.utiliser = medoc
        self.utiliser?.composer = doseU
        var date = dateDebut as Date
        

        let calendar = NSCalendar.current
        //Tant que la date n'est pas la meme que la date de fin.
        //Pour chaque jour de l'ordonnance entre la date de début et la date de fin on crée les prises associé
        while date.compare(dateFin as Date) != .orderedDescending{
            print(date)
            
            //Pour chaque heures précisées on crée une "PriseReelle"
            for heure in heures{
                let prise = PriseReelle(context: CoreDataManager.context)
                prise.datePrisePrevue = date as NSDate
                prise.datePriseReelle = nil
                prise.heurePrisePrevue = DateFormatterHelper.hoursFormatFromString(forDate: heure)
                prise.heurePriseReelle = nil
                prise.valider = false
                prise.associer = self
                
                //création de la notification associé a la prise du médicament
                NotificationHelper.scheduleNotificationMedicament(medicament: medicament, heurePrevue: prise.heurePrisePrevue! as Date)
                
            }
            //On ajoute un jour a la date pour parcourir tout les jours entre date de debut et date de fin
            date = calendar.date(byAdding: .day, value: 1, to: date as Date)!
        }

    }
    
    
 
}


