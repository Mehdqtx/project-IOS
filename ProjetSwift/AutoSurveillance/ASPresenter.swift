//
//  ASPresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 19/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class ASPresenter: NSObject {
    fileprivate var date : String = ""
    fileprivate var praticien : String = ""
    
    fileprivate var autosurveillance : Autosurveillance? = nil{
        didSet{
            if let autosurveillance = self.autosurveillance{
                if let date = autosurveillance.dateRDVNeurologue{
                    self.date = "Date du rdv : " + DateFormatterHelper.classicFormatFromDate(forDate: date)
                }
                else{
                    self.date = "N/A"
                }
                if let praticien = autosurveillance.posseder?.nomPraticien{
                    self.praticien = praticien
                }
                else{
                    self.praticien = "N/A"
                }

            }
            else{
                self.date = ""
                self.praticien = ""
            }
        }
    }
    
    func configure(theCell: ASTableViewCell?, forAS: Autosurveillance?){
        self.autosurveillance = forAS
        guard let cell = theCell else{return}
        cell.dateLabel.text = self.date
        cell.praticienLabel.text = self.praticien
    }
    
}
