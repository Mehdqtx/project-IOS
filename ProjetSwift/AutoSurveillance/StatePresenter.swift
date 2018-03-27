//
//  StatePresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 20/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import UIKit

class StatePresenter: NSObject {
    fileprivate var libEtat : String = ""
    fileprivate var date : String = ""
    
    fileprivate var etat : Etat? = nil{
        didSet{
            if let etat = self.etat{
                if let libEtat = etat.nomEtat{
                        self.libEtat = libEtat
                }
                else{
                    self.libEtat = "N/A"
                }
                if let date = etat.dateEtat{
                    self.date = DateFormatterHelper.classicFormatFromDate(forDate: date)
                }
                else{
                    self.date = "N/A"
                }
            }
            else{
                self.libEtat = ""
                self.date = ""
            }
        }
    }
    
    func configure(theCell: StateTableViewCell?, forState: Etat?){
        self.etat = forState
        guard let cell = theCell else{return}
        cell.stateLabel.text = self.libEtat
        cell.dateLabel.text = self.date
        switch self.libEtat {
        case "ON":
            cell.stateLabel.textColor = UIColor.green
        case "OFF":
            cell.stateLabel.textColor = UIColor.red
        case "DYSK":
            cell.stateLabel.textColor = UIColor.orange
        default:
            cell.stateLabel.textColor = UIColor.black
        }
    }
}
