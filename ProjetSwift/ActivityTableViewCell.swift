//
//  ActivityTableViewCell.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 04/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
