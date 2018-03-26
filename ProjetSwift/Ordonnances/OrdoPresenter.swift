//
//  OrdoPresenter.swift
//  ProjetSwift
//
//  Created by java on 18/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class OrdoPresenter: NSObject {
    fileprivate var medicament : String = ""
    fileprivate var dose : String = ""
    fileprivate var dateDebut : String = ""
    fileprivate var dateFin : String = ""
    fileprivate var frequence : String = ""
    fileprivate var heures : [String] = []
    
    fileprivate var ordonnance : Ordonnance? = nil {
        didSet{
            if let ordonnance = self.ordonnance {
                if let medic = ordonnance.utiliser?.nomMedicament{
                    self.medicament = medic
                }
                else {
                    self.medicament = "N/A"
                }
                if let doseI = ordonnance.utiliser?.composer?.libDose{
                    self.dose = doseI
                }
                else {
                    self.dose = "N/A"
                }
                if let dateD = ordonnance.dateDebutOrdo{
                    self.dateDebut = "Debut du traitement: le " +  DateFormatterHelper.dateFormatFromDate(forDate: dateD)
                }
                else {
                    self.dateDebut = "N/A"
                }
                if let dateF = ordonnance.dateFinOrdo{
                    let dateSF = DateFormatterHelper.dateFormatFromDate(forDate: dateF)
                    if dateSF != "" {
                        self.dateFin = "Fin du traitement: le " + dateSF
                    }
                    else{
                        self.dateFin = "Durée indéterminée"
                    }
                }
                else {
                    self.dateFin = "Durée indéterminée"
                }
                if let heuresO = ordonnance.heuresOrdo{
                    self.heures = heuresO as! [String]
                }
                else{
                    self.heures = ["Aucune heure précisée"]
                }
            }
            else {
                self.medicament = ""
                self.dose = ""
                self.dateDebut = ""
                self.dateFin = ""
                self.heures = []
            }
        }
    }
    
    func configure(theCell: OrdosTableViewCell?, forOrdo: Ordonnance?){
        self.ordonnance = forOrdo
        guard let cell = theCell else{return}
        cell.medicamentLabel.text = self.medicament
        cell.doseLabel.text = self.dose
        cell.dateFinLabel.text = self.dateFin
        cell.heuresLabel.text = heures.flatMap({$0}).joined(separator: ", ")

    
    }
}
