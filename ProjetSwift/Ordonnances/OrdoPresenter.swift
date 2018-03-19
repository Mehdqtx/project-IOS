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
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let dateSD = formatter.string(from: dateD as Date)
                    self.dateDebut = "Debut du traitement: le " + dateSD
                }
                else {
                    self.dateDebut = "N/A"
                }
                if let dateF = ordonnance.dateFinOrdo{
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let dateSF = formatter.string(from: dateF as Date)
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
                if let freq = ordonnance.frequenceHebdo{
                    self.frequence = "A prendre tous les " + freq
                }
                else {
                    self.frequence = "N/A"
                }
            }
            else {
                self.medicament = ""
                self.dose = ""
                self.dateDebut = ""
                self.dateFin = ""
                self.frequence = ""
            }
        }
    }
    
    func configure(theCell: OrdosTableViewCell?, forOrdo: Ordonnance?){
        self.ordonnance = forOrdo
        guard let cell = theCell else{return}
        cell.medicamentLabel.text = self.medicament
        cell.doseLabel.text = self.dose
        cell.dateFinLabel.text = self.dateFin
        cell.dureeLabel.text = self.frequence
    }
}
