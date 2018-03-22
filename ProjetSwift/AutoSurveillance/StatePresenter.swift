//
//  StatePresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 20/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class StatePresenter: NSObject {
    fileprivate var libEtat : String = ""
    fileprivate var date : NSDate = Date() as NSDate
    
    fileprivate var etat : Etat? = nil{
        didSet{
            if let etat = self.etat{
                if let libEtat = etat.caracteriser?.nomTypeEtat{
                    //print(self.date)
                    //print(etat.composer?.dateRDVNeurologue)
                    if etat.composer?.dateRDVNeurologue === self.date{
                        self.libEtat = libEtat
                    }
                }
                else{
                    self.libEtat = "N/A"
                }
            }
            else{
                self.libEtat = ""
            }
        }
    }
    
    func configure(theCell: StateTableViewCell?, forState: Etat?, andDate: NSDate?){
        self.date = andDate!
        self.etat = forState
        guard let cell = theCell else{return}
        cell.stateLabel.text = self.libEtat
    }
    
}
