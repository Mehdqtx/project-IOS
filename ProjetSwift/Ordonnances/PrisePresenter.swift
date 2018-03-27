//
//  PrisePresenter.swift
//  ProjetSwift
//
//  Created by java on 25/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class PrisePresenter: NSObject {
    
    fileprivate var datePrevue : String = ""
    fileprivate var dateReelle : String = ""
    fileprivate var heurePrevue : String = ""
    fileprivate var heureReelle : String = ""
    
    fileprivate var prise : PriseReelle? = nil {
        didSet{
            if let prise = self.prise{
                if let heurePrev = prise.heurePrisePrevue{
                    let heurePrevu = DateFormatterHelper.hoursFormatFromDate(forDate: heurePrev)
                    self.heurePrevue = "Heure prévue: " + heurePrevu
                }
                else{
                    self.heurePrevue = "N/A"
                }
                if let heurePris = prise.heurePriseReelle{
                    let heureReel = DateFormatterHelper.hoursFormatFromDate(forDate: heurePris)
                    self.heureReelle = "Pris à: " + heureReel
                }
                else{
                    self.heureReelle = "Pas encore pris"
                }
                
                if let datePrev = prise.datePrisePrevue{
                    let datePrevu = DateFormatterHelper.dateFormatFromDate(forDate: datePrev)
                    self.datePrevue = "Date prévue: " + datePrevu
                }
                else{
                    self.datePrevue = "N/A"
                }
                if let datePris = prise.datePriseReelle{
                    let dateReel = DateFormatterHelper.dateFormatFromDate(forDate: datePris)
                    self.dateReelle = "Pris le:" + dateReel
                }
                else{
                    self.dateReelle = ""
                }
            }else{
                self.heureReelle = ""
                self.heurePrevue = ""
                self.dateReelle = ""
                self.datePrevue = ""
            }
        }
    }
    
    /// Configure la cellule de la table view des Prises
    ///
    /// - Parameters:
    ///   - theCell: PriseTableViewCell
    ///   - forPrise: PriseReelle
    func configure(theCell: PriseTableViewCell?, forPrise: PriseReelle?){
        self.prise = forPrise
        guard let cell = theCell else {return}
        cell.datePrevueLabel.text = self.datePrevue
        cell.heurePrevueLabel.text = self.heurePrevue
        cell.datePriseReelleLabel.text = self.dateReelle
        cell.heurePriseReelleLabel.text = self.heureReelle
    }
    
}
