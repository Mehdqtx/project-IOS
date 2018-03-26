//
//  SyntheseActivitiesPresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 26/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import UIKit

class SyntheseActivitiesPresenter: NSObject {
    fileprivate var name : String = ""
    fileprivate var number : String = ""
    
    fileprivate var activity : Activite? = nil{
        didSet{
            if let activity = self.activity{
                if let name = activity.libActivite{
                    self.name = "Activité : " + name
                }
                else{
                    self.name = "N/A"
                }
                let numberString = String(activity.nbValidations)
                self.number = "Réalisée " + numberString + " fois"
            }
            else{
                self.name = ""
                self.number = ""
            }
        }
    }
    
    func configure(theCell: SyntheseActivitiesTableViewCell?, forActivity: Activite?){
        self.activity = forActivity
        guard let cell = theCell else{return}
        cell.activityLabel.text = self.name
        cell.numberLabel.text = self.number
    }
}
