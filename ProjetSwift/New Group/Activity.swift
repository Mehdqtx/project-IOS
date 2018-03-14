//
//  Activity.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 14/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class Activity{
    let activityDuration : Int32
    let frequency : String
    let activityName : String
    
    init(activityDuration: Int32, frequency: String, activityName: String){
        self.activityDuration = activityDuration
        self.frequency = frequency
        self.activityName = activityName
    }
}
