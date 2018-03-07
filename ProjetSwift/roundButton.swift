//
//  roundButton.swift
//  ProjetSwift
//
//  Created by java on 05/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class roundButton: UIButton {

    override func didMoveToWindow() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width : 0, height : 0)
    }

}
