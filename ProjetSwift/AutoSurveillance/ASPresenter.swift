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
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM' à' hh' h 'mm"
                    let dateString = formatter.string(from: date as Date)
                    self.date = "Date du rdv : " + dateString
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
