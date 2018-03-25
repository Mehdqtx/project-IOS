//
//  PriseTableViewCell.swift
//  ProjetSwift
//
//  Created by java on 25/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit


class PriseTableViewCell: UITableViewCell{
    
    @IBOutlet weak var heurePrevueLabel: UILabel!
    @IBOutlet weak var datePrevueLabel: UILabel!
    @IBOutlet weak var heurePriseReelleLabel: UILabel!
    @IBOutlet weak var datePriseReelleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
