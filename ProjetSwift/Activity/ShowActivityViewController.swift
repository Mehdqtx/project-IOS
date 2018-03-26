//
//  ShowActivityViewController.swift
//  ProjetSwift
//
//  Created by Maxime Soustelle on 07/03/2018.
//  Copyright © 2018 Maxime SOUSTELLE - Mehdi DELVAUX. All rights reserved.
//

import UIKit

class ShowActivityViewController: UIViewController {

    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var frequency: UILabel!
    var activity : Activite? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let anActivity = self.activity{
            self.frequency.text = anActivity.frequence! + " fois par semaine"
            self.duration.text = String(anActivity.dureeActivite) + " minutes par séance"
            self.activityName.text = anActivity.libActivite
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func validateAction(_ sender: Any) {
        self.activity?.incValidation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
