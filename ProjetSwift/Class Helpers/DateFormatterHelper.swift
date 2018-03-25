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
    
    class func minutesFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
    
    class func classicFormatFromDate(forDate dateToFormat: NSDate) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM' à' hh' h 'mm a "
        let dateFormatted = formatter.string(from: dateToFormat as Date)
        return dateFormatted
    }
}
