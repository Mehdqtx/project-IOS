//
//  SyntheseStatePresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class SyntheseStatePresenter: NSObject {
    fileprivate var libEtat : String = ""
    fileprivate var date : String = ""
    
    fileprivate var etat : Etat? = nil{
        didSet{
            if let etat = self.etat{
                if let libEtat = etat.caracteriser?.nomTypeEtat{
                    self.libEtat = libEtat
                }
                else{
                    self.libEtat = "N/A"
                }
                if let date = etat.dateEtat{
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM' à' hh' h 'mm a "
                    let dateString = formatter.string(from: date as Date)
                    self.date = dateString
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
    
    func configure(theCell: SyntheseStateTableViewCell?, forState: Etat?){
        self.etat = forState
        guard let cell = theCell else{return}
        cell.resultatLabel.text = self.libEtat
        cell.dateLabel.text = self.date
    }
    
}
