//
//  DateFormatterHelper.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 25/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class DateFormatterHelper {
    
    /// Formattage des minutes String en NSDate
    ///
    /// - Parameter dateToFormat: String, la date a transformer
    /// - Returns: renvoie les minutes au format date
    class func minutesFormatFromString(forDate dateToFormat: String) -> NSDate{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.date(from: dateToFormat) as NSDate?
        return dateFormatted!
    }
    
    /// Formattage des heures String en NSDate
    ///
    /// - Parameter dateToFormat: String, la date a transformer
    /// - Returns: renvoie l'heure + minute au format date
    class func hoursFormatFromString(forDate dateToFormat: String) -> NSDate{
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.date(from: dateToFormat) as NSDate?
        return dateFormatted!
    }
    
    /// Formattage des minutes du format NSDate en String
    ///
    /// - Parameter dateToFormat: NSDate, date
    /// - Returns: retourne date en String
    class func minutesFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    /// Formattage de l'heure de NSDate en String
    ///
    /// - Parameter dateToFormat: date en NSDAte
    /// - Returns: retourne la date en String
    class func hoursFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    /// Formattage de l'heure de date en String
    ///
    /// - Parameter dateToFormat: NSDate
    /// - Returns: heure en String
    class func hourFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    /// Formattage du format NSDate en String
    ///
    /// - Parameter dateToFormat: NSDate, date
    /// - Returns: retourne la date heure en string
    class func classicFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM' à' HH' h 'mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    /// Formattage minute de NSDate en string
    ///
    /// - Parameter dateToFormat: date
    /// - Returns: retourne les minutes en string
    class func timeFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm" 
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    /// Formattage de la date NSDate en String
    ///
    /// - Parameter dateToFormat: date
    /// - Returns: retourne la date en string
    class func dateFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    /// Formattage de la date String en NSDate
    ///
    /// - Parameter dateToFormat: String
    /// - Returns: retourne la date en NSDate
    class func dateFormatFromString(forDate dateToFormat: String) -> NSDate{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.date(from: dateToFormat)
        return dateFormatted! as NSDate
    }
    
    /// Calcul le nombre de jour entre deux dates
    ///
    /// - Parameters:
    ///   - startDate: NSDate, la premiere date
    ///   - endDate: NSdate, al deuxieme date
    /// - Returns: Retourne le nombre de jour entre ces deux dates
    class func daysBetweenDates(startDate: NSDate, endDate: NSDate)-> Int {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: startDate as Date)
        let date2 = calendar.startOfDay(for: endDate as Date)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
    
   /// Calcul du nombre de minute entre deux heures
   ///
   /// - Parameters:
   ///   - heurePrevue: NSDate, la premiere heure
   ///   - heurePrise: NSDate, la deuxieme heure
   /// - Returns: retourne le nombre de minute entre les deux heures
   class func differenceHeure(heurePrevue: NSDate, heurePrise: NSDate)-> Int{
        
        let prevueTimeHoursMinutes = Calendar.current.component(.hour, from: heurePrevue as Date) * 60
        let prevueTimeMinutes = Calendar.current.component(.minute, from: heurePrevue as Date)
        let totalPrevueTimeMinutes = prevueTimeHoursMinutes + prevueTimeMinutes
        
        // getting the number of minutes in today:
        let priseHoursMinutes = Calendar.current.component(.hour, from: heurePrise as Date) * 60
        let priseMinutes = Calendar.current.component(.minute, from: heurePrise as Date)
        let priseTimeMinutes = priseHoursMinutes + priseMinutes
        
        // difference in minutes (could be negative):
        let difference = totalPrevueTimeMinutes - priseTimeMinutes
        return difference
    }
    
    
    /// Conversion d'une heure en int
    ///
    /// - Parameter hour: NSDate, l'heure a convertir
    /// - Returns: retourne l'entier
    class func convertHourToInt(hour: NSDate)-> Int {
        let timeInterval = hour.timeIntervalSinceNow
        return Int(timeInterval)
    }
}
