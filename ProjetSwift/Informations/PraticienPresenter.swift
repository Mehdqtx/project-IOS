//
//  PraticienPresenter.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 24/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import Foundation

class PraticienPresenter: NSObject {
    fileprivate var name : String = ""
    fileprivate var phone : String = ""
    
    fileprivate var praticien : Praticien? = nil{
        didSet{
            if let praticien = self.praticien{
                if let name = praticien.nomPraticien{
                    self.name = name
                }
                else{
                    self.name = "N/A"
                }
                if let phone = praticien.telPraticien{
                    if phone != ""{
                        self.phone = phone
                    }
                    else{
                        self.phone = "Specialité non renseignée"
                    }
                }
                else{
                    self.phone = "N/A"
                }
            }
            else{
                self.name = ""
                self.phone = ""
            }
        }
    }
    
    func configure(theCell: PraticienTableViewCell?, forPraticien: Praticien?){
        self.praticien = forPraticien
        guard let cell = theCell else{return}
        cell.nameLabel.text = self.name
        cell.phoneLabel.text = self.phone
    }
}
