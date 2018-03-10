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
            self.frequency.text = anActivity.frequence
            self.duration.text = String(anActivity.dureeActivite)
            self.activityName.text = anActivity.libActivite
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
