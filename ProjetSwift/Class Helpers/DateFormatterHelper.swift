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
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func hoursFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func classicFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM' à' hh' h 'mm a "
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    class func dateFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func daysBetweenDates(startDate: NSDate, endDate: NSDate)-> Int {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: startDate as Date)
        let date2 = calendar.startOfDay(for: endDate as Date)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }
}
