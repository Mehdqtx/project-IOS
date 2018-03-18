//
//  RdvPresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 18/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class RdvPresenter: NSObject {
    fileprivate var praticien : String = ""
    fileprivate var date : String = ""
    
    fileprivate var rdv : RendezVous? = nil{
        didSet{
            if let rdv = self.rdv{
                if let praticien = rdv.concerner?.nomPraticien{
                    self.praticien = praticien
                }
                else{
                    self.praticien = "N/A"
                }
                if let date = rdv.dateRDV{
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
                self.praticien = ""
                self.date = ""
            }
        }
    }
    
    func configure(theCell: RdvsTableViewCell?, forRdv: RendezVous?){
        self.rdv = forRdv
        guard let cell = theCell else{return}
        cell.dateLabel.text = self.date
        cell.praticienLabel.text = self.praticien
    }
    
}
