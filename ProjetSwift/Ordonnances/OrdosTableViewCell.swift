//
//  OrdosTableViewCell.swift
//  ProjetSwift
//
//  Created by java on 17/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class OrdosTableViewCell: UITableViewCell {

    @IBOutlet weak var medicamentLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var dureeLabel: UILabel!
    @IBOutlet weak var dateDebutLabel: UILabel!
    @IBOutlet weak var dateFinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
