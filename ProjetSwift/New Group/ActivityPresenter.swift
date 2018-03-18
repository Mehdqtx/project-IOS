//
//  ActivityPresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 18/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class ActivityPresenter: NSObject {
    fileprivate var frequency : String = ""
    fileprivate var duration : String = ""
    fileprivate var name : String = ""
    
    fileprivate var activity : Activite? = nil{
        didSet{
            if let activity = self.activity{
                if let frequency = activity.frequence{
                    self.frequency = frequency + " fois par semaine"
                }
                else{
                    self.frequency = "N/A"
                }
                let durationString = String(activity.dureeActivite)
                self.duration = durationString + " minutes"
                if let name = activity.libActivite{
                    self.name = name
                }
                else{
                    self.name = "N/A"
                }
            }
            else{
                self.frequency = ""
                self.duration = ""
                self.name = ""
            }
        }
    }
    
    func configure(theCell: ActivityTableViewCell?, forActivity: Activite?){
        self.activity = forActivity
        guard let cell = theCell else{return}
        cell.activityName.text = self.name
        cell.durationLabel.text = self.duration
        cell.frequencyLabel.text = self.frequency
    }
    
}
