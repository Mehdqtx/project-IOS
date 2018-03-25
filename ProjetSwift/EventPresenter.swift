//
//  EventPresenter.swift
//  ProjetSwift
//
//  Created by java on 19/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class EventPresenter: NSObject {
    
    fileprivate var incident : String = ""
    fileprivate var date : String = ""
    
    fileprivate var event : Incident? = nil {
        didSet{
            if let event = self.event {
                if let incid = event.typeIncident{
                    self.incident = incid.capitalized
                }
                else{
                    self.incident = "N/A"
                }
                if let dateI = event.dateIncident{
                    self.date = "Survenue le : " + DateFormatterHelper.dateFormatFromDate(forDate: dateI)
                }
            }
            else{
                self.incident = ""
                self.date = ""
            }
            
        }
    }
    
        func configure(theCell : EventTableViewCell?, forEvent: Incident?){
            self.event = forEvent
            guard let cell = theCell else {return }
            cell.eventLabel.text = self.incident
            cell.dateEventLabel.text = self.date
        
        }
}
