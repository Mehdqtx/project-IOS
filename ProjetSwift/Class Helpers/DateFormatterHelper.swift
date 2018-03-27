//
//  DateFormatterHelper.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 25/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class DateFormatterHelper {
    class func minutesFormatFromString(forDate dateToFormat: String) -> NSDate{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.date(from: dateToFormat) as NSDate?
        return dateFormatted!
    }
    
    class func hoursFormatFromString(forDate dateToFormat: String) -> NSDate{
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.date(from: dateToFormat) as NSDate?
        return dateFormatted!
    }
    
    class func minutesFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func hoursFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    class func hourFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func classicFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM' à' hh' h 'mm a "
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func timeFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm" 
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    class func dateFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    class func dateFormatFromString(forDate dateToFormat: String) -> NSDate{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        formatter.locale = Locale(identifier:"fr_FR")
        let dateFormatted = formatter.date(from: dateToFormat)
        return dateFormatted! as NSDate
    }
    
    class func daysBetweenDates(startDate: NSDate, endDate: NSDate)-> Int {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: startDate as Date)
        let date2 = calendar.startOfDay(for: endDate as Date)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
    
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
    
    class func convertHourToInt(hour: NSDate)-> Int {
        let timeInterval = hour.timeIntervalSinceNow
        return Int(timeInterval)
    }
}
