//
//  SynthesePilulierPresenter.swift
//  ProjetSwift
//
//  Created by java on 26/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation
import UIKit

class SynthesePilulierPresenter: NSObject {
    fileprivate var datePrevue : String = ""
    fileprivate var dateReelle : String = ""
    fileprivate var heurePrevue : String = ""
    fileprivate var heureReelle : String = ""
    fileprivate var resultat : String = ""
 
    
    fileprivate var prise : PriseReelle? = nil {
        didSet{
            if let prise = self.prise {
                if let datePrisePrevue = prise.datePrisePrevue{
                    self.datePrevue = "Prevue le: " + DateFormatterHelper.dateFormatFromDate(forDate: datePrisePrevue)
                }
                else {
                    self.datePrevue = "N/A"
                }
                if let datePriseReelle = prise.datePriseReelle{
                    self.dateReelle = "Pris le: " + DateFormatterHelper.dateFormatFromDate(forDate: datePriseReelle)
                }
                else {
                    self.dateReelle = "N/A"
                }
                if let heurePrevue = prise.heurePrisePrevue{
                    self.heurePrevue = "Prevue: " + DateFormatterHelper.hoursFormatFromDate(forDate: heurePrevue)
                }
                else {
                    self.heurePrevue = "N/A"
                }
                if let heurePrise = prise.heurePriseReelle{
                    self.heureReelle = "Pris: " + DateFormatterHelper.hoursFormatFromDate(forDate: heurePrise)
                }
                else {
                    self.heureReelle = "N/A"
                }
                if let heurePriseR = prise.heurePriseReelle, let heurePriseP = prise.heurePrisePrevue{
                    let diff = DateFormatterHelper.differenceHeure(heurePrevue: heurePriseP, heurePrise: heurePriseR)
                    if diff >= 30 {
                        self.resultat = "Pris en retard!"
                    }
                    else if diff <=  -30{
                        self.resultat = "Pris trop à l'avance"
                    }
                    else{
                        self.resultat = "Pris à l'heure"
                    }

                }
                else{
                    self.resultat = ""
                }
            }
            else {
                self.dateReelle = ""
                self.datePrevue = ""
                self.heureReelle = ""
                self.heurePrevue = ""
                self.resultat = ""
            }
        }
    }
    
    func configure(theCell: SynthesePilulierTableViewCell?, forPrise: PriseReelle?){
        self.prise = forPrise

        guard let cell = theCell else{return}
        cell.datePriseReelleLabel.text = self.dateReelle
        cell.heurePrisePrevueLabel.text = self.heurePrevue
        cell.heurePriseReelleLabel.text = self.heureReelle
        cell.resultatLabel.text = self.resultat
        if self.resultat != "Pris à l'heure"{
            cell.resultatLabel.textColor = #colorLiteral(red: 1, green: 0.2503060105, blue: 0, alpha: 1)
        }
        else{
            cell.resultatLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        
    }
    
    
}
