//
//  SynthesePilulierTableViewCell.swift
//  ProjetSwift
//
//  Created by java on 26/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class SynthesePilulierTableViewCell: UITableViewCell {
    

    @IBOutlet weak var datePriseReelleLabel: UILabel!
    @IBOutlet weak var resultatLabel: UILabel!
    @IBOutlet weak var heurePriseReelleLabel: UILabel!
    @IBOutlet weak var heurePrisePrevueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
